# Install

## Install

Run the following commands on a fresh Ubuntu Xenial 16.04 (x64) server:

```
wget https://cloudron.io/cloudron-setup
chmod +x cloudron-setup
./cloudron-setup --provider <azure|cloudscale|digitalocean|ec2|exoscale|hetzner|linode|ovh|rosehosting|scaleway|vultr|generic>
```

!!! note "Minimum Requirements"
    Cloudron requires atleast 1GB RAM, 20GB Disk space. Make sure the firewall does not block port 80 (http)
    and 443 (https). Cloudron does not support running on ARM, LXC or OpenVZ.

!!! tip "Referral codes"
    [DigitalOcean](https://m.do.co/c/933831d60a1e),
    [hosttech](https://www.hosttech.ch/?promocode=53619290), [Linode](https://www.linode.com/?r=f68d816692c49141e91dd4cef3305da457ac0f75),
    [Rosehosting](https://secure.rosehosting.com/clientarea/?affid=661), [Vultr](http://www.vultr.com/?ref=7110116-3B).

## Domain Setup

Once installation is complete, navigate to `https://<IP>` and accept the self-signed certificate.

<center>
<img src="/img/setupdns.png" class="shadow" width="500px">
</center>

Provide a domain like `smartserver.io`. Cloudron's admin interface will then be available at the `my.smartserver.io`
and apps will be installed into subdomains like `blog.smartserver.io`, `git.smartserver.io` and so on.

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

Once DNS is setup, Cloudron will get a certificate (via Let's Encrypt) and redirect to 
`https://my.domain`. The browser address bar will show a green lock to indicate
that the connection to your Cloudron is now secure.

<center>
<img src="/img/setup-admin2.png" class="shadow" width="500px">
</center>

Enter the adminstrator username, email and password for the Cloudron. Some usernames like `admin`
are reserved because apps associate special meanings to them.

The email address is used for password resets and for apps to send notifications. It is local to
your Cloudron and not sent anywhere (including cloudron.io).

!!! warning "Let's Encrypt requires a valid email"
    Cloudron sets up a Let's Encrypt account with the administrator's email. If this email
    address is not valid, Let's Encrypt will not issue certificates.

## Cloudron Store Setup

You are now ready to start installing apps! When you click on the `App Store` link in the UI,
you will be prompted to create a [cloudron.io](https://cloudron.io) account. This account is
used to manage your subscription & billing.

## Next steps

Security is a core feature of the Cloudron and the default installation is already setup
to follow [best practices](/documentation/security/).

To further harden security, we recommend the following:

* [Secure SSH access](/documentation/security/#securing-ssh-access) to the server

## Setup issues

Please [email us](mailto:support@cloudron.io) or join our <a href="https://forum.cloudron.io" target="_blank">forum</a>
for any questions.

