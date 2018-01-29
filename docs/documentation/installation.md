# Install

## Install

Create a server with Ubuntu Xenial 16.04 (x64) and run these commands:
```
wget https://cloudron.io/cloudron-setup
chmod +x cloudron-setup
./cloudron-setup --provider <azure|cloudscale|digitalocean|ec2|exoscale|hetzner|linode|ovh|rosehosting|scaleway|vultr|generic>
```

!!! note "Minimum Requirements"
    Cloudron requires atleast 1GB RAM, 20GB Disk space. Make sure the firewall does not block port 80 (http)
    and 443 (https). Cloudron does not support running on ARM, OpenVZ or LXC.

!!! tip "Referral codes"
    [DigitalOcean](https://m.do.co/c/933831d60a1e),
    [hosttech](https://www.hosttech.ch/?promocode=53619290), [Linode](https://www.linode.com/?r=f68d816692c49141e91dd4cef3305da457ac0f75),
    [Rosehosting](https://secure.rosehosting.com/clientarea/?affid=661), [Vultr](http://www.vultr.com/?ref=7110116-3B).

## Domain Setup

Once the installation is complete, navigate to `https://<IP>` and accept the self-signed certificate.

<center>
<img src="/img/setupdns.png" class="shadow" width="500px">
</center>

Provide a [second level domain](https://en.wikipedia.org/wiki/Second-level_domain) like `smartserver.io`.
Cloudron's web interface will then be available at the `my.smartserver.io` and apps will be installed
into subdomains like `blog.smartserver.io`, `git.smartserver.io` and so son.

It is safe to use a domain name that is already in use, just make sure that the `my` subdomain is available.

Select the DNS service in which the domain in hosted:

*   [AWS Route53](/documentation/domains/#route-53-dns)
*   [Cloudflare](/documentation/domains/#cloudflare-dns)
*   [Digital Ocean](/documentation/domains/#cloudflare-dns)
*   [Google Cloud DNS](/documentation/domain/#google-cloud-dns)
*   [Wildcard](/documentation/domains/#wildcard-dns)

When using one of the programmable backends, Cloudron will automatically make changes to DNS
as and when required.

## Administrator Setup

Once the DNS is setup, Cloudron will get a certificate via Let's Encrypt and redirect to 
`https://my.<domain>`. The browser address bar will show a green lock to indicate
that the connection to your Cloudron is now secure.

Enter the adminstrator username, email and password for the Cloudron. Some usernames like `admin`
are unfortunately reserved because apps attach special meanings to them.

The email id entered here is local to your Cloudron and not sent anywhere (including cloudron.io).

!!! warning "Let's Encrypt requires a valid email"
    Cloudron sets up a Let's Encrypt account with the administrator's email. If this email
    is not valid, Let's Encrypt will not issue certificates.

## Cloudron Store Setup

You are now ready to start installing apps! When you click on the `App Store` link in the UI,
you will be prompted to create a [cloudron.io](https://cloudron.io) account. This account is
used to manage your subscription & billing.

## Community

Please join our <a href="https://chat.cloudron.io" target="_blank">chat</a> for any questions.

