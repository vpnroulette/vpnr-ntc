#!/bin/bash 


INSTALL_PATH="/opt/"
NTC_SOURCE_URL=""
NODESTATUS_SOURCE_URL=""


echo "Installing dependencies.................."

DEPENDENCIES=('curl' 'figlet' 'toilet' 'node' 'npm' 'docker' 'git' 'openvpn')

function installdeps() {
	echo ""
}


function get_sources() {
	cd ${INSTALL_PATH} && git clone ${NTC_SOURCE_URL} && git clone ${NODESTATUS_SOURCE_URL}

}

### get sources: 
# - NTC Nodestation Tunel Constructor
# - VPN status

# Then genconfig for ovpn and once we have public_ip_addr + hostname + ovpn cfg
# we set the config params into ovpn-status config file and launch everything 


## TODO: Firewall & security measures
