#!/bin/bash 

echo "Unisntalling VPNR NTC............."

removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

armageddon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

function uninstall() {
	# Remove installed packages if you want
	apt-get  remove --purge npm openvpn figlet toilet docker.io git
	# Remove configuration files
	rm -rf /opt/openvpn-status/
	rm -rf /usr/local/bin/vpnr-ntc
	rm -rf /lib/systemd/system/ovpnstatus.service 
}

echo "WARNING! Executing Docker Armagedon!"
echo "This is going to destroy ALL images and volumes inside your docker"
echo "Are you sure? [y/n]"
read r
case r in: 
	Y|y) uninstall && armageddon ;;
	N|n) echo "Bye" && exit 0 ;;
	*) echo "??" && exit 1 ;;
esac

echo "VPNR NTC Uninstalled succesfully!"
