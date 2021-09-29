#!/bin/bash


INSTALL_PATH="/opt"
NTC_IMG="zpol/vpnr-ntc-raspi:latest"
SP="\e[35m>> \e[92m"
NC="\e[39m"
ER="\e[35m>> \e[31m"
PKG_DEPENDENCIES=('curl' 'figlet' 'toilet' 'npm' 'docker.io' 'git')
SRC_DEPENDENCIES='https://github.com/AuspeXeu/openvpn-status.git'

OVPNSTATUS_CFG=' { "port": 3013, "bind": "0.0.0.0", "servers": [ {"id": 0, "name": "VPNRoulette NTC", "host": "127.0.0.1","man_port": 7656} ], "username": "admin", "password": "admin", "web": { "dateFormat": "HH:mm - DD.MM.YY" } }'
OVPNSTATUS_SERVICE="etc/ovpnstatus.service"
BANNER="etc/banner"

function syschecks() {
	# check if root 
	if [ $UID != "0" ]; then
		echo "Installation needs root permissions, please execute as root."
		exit 3
	fi
}


function banner() {
	clear
	cat ${BANNER}
	syschecks
}


function installdeps() {

	for src in ${SRC_DEPENDENCIES[@]}; do
		echo -e "${SP} Installing ( Control Dashboard ) ......${NC}"
		echo -e "${SP} - Configuring Control dashboard [1/2]${NC}"
		cp ${OVPNSTATUS_SERVICE} /lib/systemd/system/
		systemctl enable ovpnstatus.service
		cd ${INSTALL_PATH} && git clone ${src}
		echo -e "${SP} - Compiling frontend (It can take a while be patient...) ${NC}"
		cd openvpn-status 
		npm install 
		npm run build 
		echo -e "${SP} - Configuring Control dashboard [2/2]${NC}"
		echo ${OVPNSTATUS_CFG} > cfg.json

	done

	#apt-get update
	apt-get install -y ${PKG_DEPENDENCIES[@]}

}


function checks() {
	docker_status=$(systemctl show --property ActiveState docker|cut -d= -f2)
	default_iface=$(netstat  -rn |grep UG |awk {' print $8'})
	ip_addr=$(ifconfig ${default_iface}|grep netmask|awk {' print $2'})
	if [ $docker_status != "active" ]; then 
		echo -e "${ER}[ERR] - Can't find Docker daemon, please check if it's running...${NC}"
	else
		echo -e "${SP} Docker daemon running: OK :)${NC}"
		echo -e "${SP} - Downloading VPNR docker images......${NC}"
		docker pull ${NTC_IMG}
		echo -e "${SP} Installing VPNR NTC ......${NC}"
		cp $(dirname $0)/etc/vpnr-ntc /usr/local/bin/
		echo -e "${SP} Type: vpnr-ntc to start the VPN server and connect to http://${ip_addr}:3013 to see the dashboard${NC}"
		
	
	fi

}


banner
installdeps
checks


### get sources:
# - NTC Nodestation Tunel Constructor
# - VPN status

# Then genconfig for ovpn and once we have public_ip_addr + hostname + ovpn cfg
# we set the config params into ovpn-status config file and launch everything


## TODO: Firewall & security measures
