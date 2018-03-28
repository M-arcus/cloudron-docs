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

