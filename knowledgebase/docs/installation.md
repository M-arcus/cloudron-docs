# Install

## Install

Run the following commands on a fresh Ubuntu Bionic 18.04 (x64) server:

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
<img src="/documentation/img/setupdns.png" class="shadow" width="500px">
</center>

Provide a domain like `smartserver.io`. Cloudron's admin interface will then be available at the `my.smartserver.io`
and apps can be installed into subdomains like `blog.smartserver.io`, `git.smartserver.io` and so on. More domains
can be added after installation is complete in the [Domains](domains/) view.

It is safe to use a domain name that is already in use, just make sure that the `my` subdomain is available.
Cloudron will never overwrite existing DNS records.

Next, select the DNS service in which the domain in hosted:

*   [AWS Route53](/documentation/domains/#route-53-dns)
*   [Cloudflare](/documentation/domains/#cloudflare-dns)
*   [Digital Ocean](/documentation/domains/#cloudflare-dns)
*   [Gandi](/documentation/domains/#gandi-dns)
*   [GoDaddy](/documentation/domains/#godaddy-dns)
*   [Google Cloud DNS](/documentation/domain/#google-cloud-dns)
*   [name.com](/documentation/domains/#namecom-dns)
*   [Wildcard](/documentation/domains/#wildcard-dns)

When using one of the programmable backends, Cloudron will automatically make changes to DNS
as and when required.

!!! note "Common domain registrars"
    You can always purchase a domain from any of the common domain registrars
    like Namecheap, Name.com, Gandi and <a href="https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars" target="_blank">setup your domain's nameservers</a> to use one of the above DNS services.

## Administrator Setup

Once DNS is setup, Cloudron will redirect to `https://my.domain.com`.
The browser address bar will show a green lock to indicate that the connection to your
Cloudron is now secure (It does this by automatically getting a certificate via Let's Encrypt).

<center>
<img src="/documentation/img/setup-admin2.png" class="shadow" width="500px">
</center>

Enter the adminstrator username, email and password for the Cloudron.

The email address is used for password resets and for apps to send notifications. It is local to
your Cloudron and not sent anywhere (including cloudron.io).

!!! warning "Let's Encrypt requires a valid admin email"
    Cloudron sets up a Let's Encrypt account with the administrator's email. If this email
    address is not valid, Let's Encrypt will not issue certificates and Cloudron will fallback
    to using self-signed certs.

## App Store Setup

You are now ready to start installing apps! When you click on the `App Store` link in the UI,
you will be prompted to create a [cloudron.io](https://cloudron.io) account. This account is
used to manage your subscription & billing.

<center>
<img src="/documentation/img/appstore-signup.png" class="shadow" width="500px">
</center>

## Next steps

Security is a core feature of the Cloudron and the default installation is already setup
to follow [best practices](/documentation/security/).

To further harden security, we recommend the following:

* [Secure SSH access](/documentation/security/#securing-ssh-access) to the server
* [Setup Cloud Firewall](/documentation/security/#configuring-cloud-firewall)

## Support

If you have problems setting up Cloudron, please [email us](mailto:support@cloudron.io) or
ask in our <a href="https://forum.cloudron.io" target="_blank">forum</a>.

