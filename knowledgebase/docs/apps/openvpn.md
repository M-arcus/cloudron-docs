# <img src="/documentation/img/openvpn-logo.png" width="25px"> OpenVPN App

## Desktop and Mobile Clients

The OpenVPN app has been tested with the following clients:

* NetworkManager on Ubuntu
* [Tunnelblick](https://www.tunnelblick.net/) on Mac OS X
* [OpenVPN for Android](https://play.google.com/store/apps/details?id=de.blinkt.openvpn)

## How to connect on Ubuntu 16.04

* Install the Network Manager OpenVPN plugin
```
sudo apt-get install network-manager-openvpn-gnome
```

* Download the .ovpn embedded certs config file from the OpenVPN app

<center>
<img src="/documentation/img/openvpn-config.png" class="shadow">
</center>

* Open Network Manager, `VPN Settings` -> `Import from file...`

## Privacy

The OpenVPN app provides a tunnel to channel all the traffic from your
devices via the Cloudron. Websites and services that you visit will
not see the IP address of your devices but they *will* see the IP
address and possibly the RDNS hostname of your Cloudron.

You can check what sort of information can be gathered from your
Cloudron's IP address using [ipleak.net](https://ipleak.net).

## Troubleshooting

If you are unable to connect to the OpenVPN server, make sure that your VPS firewall
allows the OpenVPN port (by default, this is 7494/TCP). For example, you might have
to add this incoming port as part of EC2 security group.

