# Install

## Install

Run the following commands on a fresh Ubuntu Bionic 18.04 (x64) server:

```
wget https://cloudron.io/cloudron-setup
chmod +x cloudron-setup
./cloudron-setup --provider <azure|cloudscale|digitalocean|ec2|exoscale|hetzner|linode|netcup|ovh|rosehosting|scaleway|vultr|generic>
```

!!! note "Minimum Requirements"
    Cloudron requires atleast 1GB RAM, 20GB Disk space. Make sure the firewall does not block port 80 (http)
    and 443 (https). Cloudron does not support running on ARM, LXC or OpenVZ.

!!! tip "Referral codes"
    [netcup](https://www.netcup.de/), [DigitalOcean](https://m.do.co/c/933831d60a1e),
    [hosttech](https://www.hosttech.ch/?promocode=53619290), [Linode](https://www.linode.com/?r=f68d816692c49141e91dd4cef3305da457ac0f75),
    [Rosehosting](https://secure.rosehosting.com/clientarea/?affid=661), [Vultr](http://www.vultr.com/?ref=7110116-3B).

## Setup

Once installation is complete, navigate to `https://<IP>` in your browser and accept the self-signed
certificate.

In Chrome, you can accept the self-signed certificate by clicking on `Advanced` and then 
click `Proceed to <ip> (unsafe)`. In Firefox, click on `Advanced`, then `Add Exception` and
then `Confirm Security Exception`.

At this point, the Cloudron setup wizard should appear.

### Domain Setup

Provide a domain like `example.com`.  The way Cloudron works is that the dashboard gets installed at
 `my.example.com` and apps are installed under subdomains that you specify like `git.example.com`,
`chat.example.com` and so on.

It is perfectly safe to use a domain that is already in use as long as the `my` subdomain is available.
When installing apps, Cloudron will never overwrite your existing DNS records and your existing subdomains
remain intact. It is also possible to use a subdomain like `cloudron.example.com`.

<center>
<img src="/documentation/img/setupdns.png" class="shadow" width="500px">
</center>

Next, select the DNS service in which the domain in hosted. If your service is not listed below, use the
`Wildcard` or `Manual` option.

*   [Cloudflare](/documentation/domains/#cloudflare-dns)
*   [Digital Ocean](/documentation/domains/#digitalocean-dns)
*   [Gandi](/documentation/domains/#gandi-dns)
*   [GoDaddy](/documentation/domains/#godaddy-dns)
*   [Google Cloud DNS](/documentation/domain/#google-cloud-dns)
*   [name.com](/documentation/domains/#namecom-dns)
*   [Namecheap](/documentation/domains/#namecheap-dns)
*   [Route53](/documentation/domains/#route-53-dns)
*   [Wildcard](/documentation/domains/#wildcard-dns)
*   [Manual](/documentation/domains/#manual-dns)

!!! note "Primary domain"
    The first domain added on the Cloudron is called the `Primary Domain`. The dashboard is made available
    under the `my` subdomain of the primary domain. More domains can be added after installation in the
    in the [Domains view](/documentation/domains). The Primary Domain can be changed post installation.

### Admin Account

Once DNS is setup, Cloudron will redirect to `https://my.example.com`. The browser address bar
will show a green lock to indicate that the connection to your Cloudron is now secure.

<center>
<img src="/documentation/img/setup-admin2.png" class="shadow" width="500px">
</center>

Enter the adminstrator username, email and password for Cloudron.

The email address is used for password resets and notifications. It is local to
your Cloudron and not sent anywhere (including cloudron.io).

!!! warning "Let's Encrypt requires a valid admin email"
    Cloudron sets up a Let's Encrypt account with the administrator's email. If this email
    address is not valid, Let's Encrypt will not issue certificates and Cloudron will fallback
    to using self-signed certs.

### App Store Account

You are now ready to start installing apps! When you click on the `App Store` link in the UI,
you will be prompted to create a [cloudron.io](https://cloudron.io) account. This account is
used to manage your subscription & billing.

<center>
<img src="/documentation/img/appstore-signup.png" class="shadow" width="500px">
</center>

### Firewall Setup

Security is a core feature of Cloudron and the default installation is already setup
to follow [best practices](/documentation/security/). We do not recommend adding and modifying
rules in `iptables` since Cloudron already does this (all unneeded ports are blocked).

To further harden security, we recommend configuring the VPS Firewall (in your VPS provider
control panel) by following [the firewall docs](/documentation/security/#configuring-cloud-firewall).

