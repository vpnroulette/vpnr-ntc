# vpnr-ntc
VPNRoulette Node Tunnel Constructor

## What is this?

VPNRoulette is a service that allows everyone to access a free random VPN tunnel across the whole planet.
Used basically to change your browsing origin country

**Website:** http://vpnroulete.com

**Dashboard:** http://api.vpnroulette.com:81

**Version:** `Beta 0.1.0`


## How to use it?
Almost everyone use the VPN to: hide their original IP address and remain anonymous, access to information that is censored from where you're connecting, or just to browse the net with some security guarantee.

VPNRoulette is based on OpenVPN so it's fully compatible with almost any device you want to use with it.
It uses the OpenSSL encryption library extensively, as well as the TLS protocol, and contains many security and control features. It uses a custom security protocol that utilizes SSL/TLS for key exchange. And it is capable of traversing network address translators (NATs) and firewalls so it's our preferred choice.

It can be used on almost any device you want to connect with.

### Limitations
* There's a Free Tier where everyone* can get a tunnel from the website, the Free Tier is limited to 3 tunnels per day per IP address. The free Tier it also has limited functionalities.

* The subscription plans allow users to enjoy more advanced & cool features like:
  * Interconnected worldwide VPNs: create your own private network and interconnect all the devices you want
  * Choose your favorite country or preferred node
  * Search by latency or nickname
  * Access to hidden/undetectable tunnels (When bypassing fwalls is needed ;) )

## Quickstart

* [Quickstart for Linux & mac](doc/quickstart.md) (tested on Debian & MacOSX Catalina)
* [Quickstart for Windows](doc/quickstart.md) (tested on Windows 10)
* [Quickstart for Mobile devices](doc/quickstart.md) ( Android, iOS ) [PENDING]

---

# Becoming a node and joining The Comuunity (using vpnr NTC (Node Tunnel Constructor))

Becoming a node of VPNroulette community network is just take advantadge of some old computer or raspi to install a linux and run one or more OpenVPN servers to help grow the global network.
This way you can enjoy the benefits of becoming a network node:

* ✅  Access to special features (Invisible Tunnels)
* ✅  Select desired country
* ✅  Filter results
* ✅  Access to privileged Discord channels with the latest news about the project
* ✅  Contribute to make the global network grow up
* ✅  Acess hundreds of tunnels arround the globe
* ✅  Possibility to monetize your Internet connection by being paid bor your bandwidth ( EXPERIMENTAL )**
* ✅  Learn in deep how vpn's work.


** We're going to jump into the blockchain soon, so the project may change due to several refactors that should be made in the current source code.

### How do I become a node?

Requisites:
* Fisrt of all you need to be registered in http://vpnroulette.com
* Create a SECRET_TOKEN in your personal dashboard
* Download Nodestation
* Install Nodestation
* Configure your SCERET_TOKEN in the Nodeatation config file
* Make the proper network adjustments to be sure that the ports opened on the node are vivible from the public Internet.
* Run nodestation and check that VPNroulette detects your node.


### How the global network works?

Basically your node is one of hundreds spreaded arround the globe. The main point here is to generate as much tunnels as we can ( or as much a you want to, you can set NUM_CLIENTS parameter to X )

The nodestation is just a bunch of scripts and functions that help you to generate tunnels automatically by creating the CA (Certificate Authority) certificates and keys, generate the Diffie Hellmann and the proper keys and certificates for as mush users as you want or your device can support.
It works similar to our nodes but in your own computer.

Once the node is up & running it sends the tunnels information encoded to VPNR API where is stored in a database. This database is queried every time a user does a request for a tunnel on the website.

A node owner will have the possibility to choose:
* How many VPN_SERVERS will run
* How many VPN_CLIENTS will accept at the same time
* If clients can see each other into the VPN network
* How often you have to cleanup and recycle/rotate the certificates and keys [EXPERIMENTAL]
  * This is a way to increase the security and generate every (i.e. 24h) new certificates and keys and delete the old ones.


* How many bandwidth to use [QoS STILL NOT AVAILABLE - EXPERIMENTAL]

Please if you join the community network you must follow the rules and not tamper with the device for malicious activities like trying to spy users connections or any other activity tha could be considered evil. All the nodes that we receive an inquire from will be banned automatically from our network FOREVER! So keep in mind that your acts can affect multiple persons, be responsible, respectfull and kind with everyone. You can report malicious activities to our Discord channels for that purpose.

### Configuring Nodestation

- [How to configure Nodesatation on Debian 10](#)


# Is it 100% secure?
VPNroulette deletes all the log files in all the nodes every 120min aprox so while this does not change there won't be any kind of users activity anywhere. Consider using always hight quality tunnels from VPNRoulette. Tunnels that come from The Comuunity could not be 100% secure (we just can't guarantee), that's why there's a payment subscription.

# Disclaimer
Nor the authors either the contributors of this source code or even vpnroulette has any resposability of any damage caused by using this software. This is literally an experiment that came from an idea about having enought VPN tunnels for everyone who needs one "right now". If you use this software is STRICTLY UNDER YOUR OWN RESPONSABILITY. Be sure to understand all the implications regarding allowing incoming connections to a device inside your network. Even the authors taking care about the security someone could be able to tamper with the hardware and maybe eventually steal some personal data or any other thing in transit. So please read the documentation carefully and be sure to understand all the technical concepts before start playing with this, specially if you're not a technician. If you need help remember that you can make a question on the forum or join the proper communication channels designed for that like Discord.


---

# >> nodestation <<
## VPNroulette NTC ( Node Tunnel Constructor )

**Version:** `0.0.5`

## Dependencies:

- docker.io
- toilet
- jq
- curl
- pwgen

Install all dependencies: `apt-get install -y docker.io toilet figlet jq curl pwgen`

## Usage:

`./nodestation.sh $(curl ifconfig.io) -s<num_servers> -c1<num_clients>`

Example
`./nodestation.sh $(curl ifconfig.io) -s1 -c1`

## Configuration
Edit the `nodestation.sh` file and change the values you need:
RECOMENDED: Just use the default values.

| Parameter name| Default value |Description |
|---------------|---------------|-------------|
|`NUMCLIENTS`|`1`|# of client access credentials to generate|
|`NUMSERVERS`|`1`|# of servers to spin up|
|`SERVER_HOST`|`$1`|The server's hostname/IP address to put into the client configuration files. (There's no need to be changed)|
|`VPN_TUNNEL_TTL`|`10800`|NOT USED NOW - EXPERIMENTAL|
|`CLIENTNAME`|`client`|It's just how the tmp filenames will be named(Does not need to be changed)|
|`OVPN_RANDOMPORT`|`$(echo $((200 + $RANDOM % 11194)))`|Random `UDP` ports between `200-11194`|
|`OVPN_PROTO`|--|--|
|`OVPN_STATS`|--|--|
|`OVPN_METRICS_EXPORTER`|--|--|


### Linux (Debian)
de
### Raspi4 (Raspbian)
de
## Overview:
```
.
├── README.md
├── includes
│   ├── bash_colors.sh
│   ├── functions.sh            [Core functions]
│   ├── heartbeat.sh            [PoC for receiving health checks from every node: EXPERIMENTAL]
│   └── register_node.sh        [Register the node into VPNR API]
├── nodestation.sh              [Main script]
└── tools
    ├── cleaner.sh              [Cleanup all VPNR related containers]
    ├── controller.sh           
    ├── get_public_ip_addr.sh
    ├── metrics_exporter.sh
    └── openvpn-monitor.sh

```
