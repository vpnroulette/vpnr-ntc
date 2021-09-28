#!/bin/bash 

clear
toilet --metal -f smblock "VPNRoulette NTC"
echo ">> Generating certificates .........(This can take a while, up to ~3-10min)"
rstring=$(pwgen -1)
OVPN_DATA="ntc-volume-data"
#OVPN_DATA="hdtest-${rstring}"
CONTAINER_NAME="vpnr-${rstring}"
PUBLIC_IP_ADDR=$(curl -s ifconfig.io)
VPNR_NTC_IMG="vpnr-ntc-raspi"

docker run -v $OVPN_DATA:/etc/openvpn --rm ${VPNR_NTC_IMG} ovpn_genconfig -u udp://${PUBLIC_IP_ADDR}
docker run -v $OVPN_DATA:/etc/openvpn --rm -it ${VPNR_NTC_IMG} ovpn_initpki nopass -e "EASY_RSA_BATCH=1"
docker run -v $OVPN_DATA:/etc/openvpn -d --name ${CONTAINER_NAME} -p 7656:7656/tcp -p 1194:1194/udp --cap-add=NET_ADMIN  ${VPNR_NTC_IMG}


CLIENTNAME="client-${rstring}"

echo "Generating client config into /tmp/${CLIENTNAME}"
docker run -v $OVPN_DATA:/etc/openvpn --rm -it ${VPNR_NTC_IMG} easyrsa build-client-full ${CLIENTNAME} nopass
docker run -v $OVPN_DATA:/etc/openvpn --rm ${VPNR_NTC_IMG} ovpn_getclient ${CLIENTNAME} > /tmp/${CLIENTNAME}.ovpn
