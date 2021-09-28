#!/bin/bash


INSTALL_PATH="/opt"
NTC_IMG="zpol/vpnr-ntc-raspi:latest"
SP="\e[35m>> \e[92m"
NC="\e[39m"
ER="\e[35m>> \e[31m"
PKG_DEPENDENCIES=('curl' 'figlet' 'toilet' 'node' 'npm' 'docker.io' 'git' 'openvpn')
SRC_DEPENDENCIES='https://github.com/AuspeXeu/openvpn-status.git'

OVPNSTATUS_CFG=' { "port": 3013, "bind": "0.0.0.0", "servers": [ {"id": 0, "name": "VPNRoulette NTC", "host": "127.0.0.1","man_port": 7656} ], "username": "admin", "password": "admin", "web": { "dateFormat": "HH:mm - DD.MM.YY" } }'
OVPNSTATUS_SERVICE="etc/ovpnstatus.service"
BANNER="etc/banner"

function banner() {
	clear
	cat ${BANNER}
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
	if [ $docker_status != "active" ]; then 
		echo -e "${ER}[ERR] - Can't find Docker daemon, please check if it's running...${NC}"
	else
		echo -e "${SP} Docker daemon running: OK :)${NC}"
		echo -e "${SP} - Downloading VPNR docker images......${NC}"
		docker pull ${NTC_IMG}
	
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
