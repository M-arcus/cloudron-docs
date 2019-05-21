# Domains

## Overview

The `Domains` view can be used to add a domain for use by Cloudron. Once added,
apps can be installed as subdomains of the added domain. The
[Cloudron Email Server](/documentation/email) can also be enabled on a per-domain basis.

<center>
<img src="../img/domains.png" class="shadow" width="600px">
</center>

Cloudron integrates with various DNS service APIs to automate DNS setup. Using the API,
Cloudron can also get Wildcard certificates via Let's Encrypt. This approach helps in hiding
an app's domain from the [Certificate Transparency Log](/documentation/security/#ssl-security).

If your DNS provider is not supported yet, we recommend using the [Wildcard](#wildcard-dns) provider.

## DNS providers

### Cloudflare DNS

To get started:

* Ensure that your domain is hosted on Cloudflare. If your domain is not hosted on Cloudflare, you can follow
  the [Cloudflare 101](https://support.cloudflare.com/hc/en-us/sections/200820158-Cloudflare-101) guide.

* Once your domain is on Cloudflare, get the [Global API Key](https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-CloudFlare-API-key-)
  available in the profile section of your account.

* In the Cloudron dashboard, choose Cloudflare from the drop down and provide the API key.

    <center>
    <img src="../img/domains-cloudflare.png" class="shadow" width="500px">
    </center>

!!! note "DNS and HTTP Proxy"
    Cloudron configures Cloudflare to proxy only the DNS. If you change this setting in Cloudflare to proxy HTTP traffic as well,
    be sure to use the [Full SSL (Strict)](https://support.cloudflare.com/hc/en-us/articles/200170416-What-do-the-SSL-options-mean-) mode.

### DigitalOcean DNS

To get started:

* Ensure that your domain is hosted on DigitalOcean. If your domain is not hosted in DigitalOcean, you can
  follow this [tutorial](https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars) to point your domain's nameservers to DigitalOcean nameservers.

* Once your domain is on DigitalOcean DNS, create an [APIv2 token](https://www.digitalocean.com/docs/api/create-personal-access-token/)
with read+write access.

* In the Cloudron dashboard, choose DigitalOcean from the drop down and provide the API key.

    <center>
    <img src="../img/domains-digitalocean.png" class="shadow" width="500px">
    </center>

### Gandi LiveDNS

If you purchased a domain from Gandi, you can use [Gandi LiveDNS](http://doc.livedns.gandi.net/) for DNS
integration.

To get started:

* Ensure that your domain is using LiveDNS. Go the `DNS Records` page in Gandi to verify that you are
  using LiveDNS. Old domains might see a `Switch to LiveDNS` banner. If you see this, click on
  `Gandi's DNS Records` button and wait for 2-3 hours for Gandi to migrate the domain.

* Next, create an LiveDNS API key from the [security section](https://account.gandi.net/en/)

* In the Cloudron dashboard, choose Gandi LiveDNS from the drop down and provide the API key.

    <center>
    <img src="../img/domains-gandi.png" width="500px" class="shadow">
    </center>

### GoDaddy

If your domain is registered with [GoDaddy](https://www.godaddy.com), you can use Cloudron's GoDaddy DNS backend to manage the DNS.

To get started:

* Create a GoDaddy API Key at their [developer portal](https://developer.godaddy.com/). When creating a new
  key **select production environment**.

    <center>
    <img src="../img/domains-godaddy-portal.png" width="500px" class="shadow">
    </center>


* In the Cloudron dashboard, choose GoDaddy from the drop down and provide the key and secret.

    <center>
    <img src="../img/domains-godaddy.png" width="500px" class="shadow">
    </center>

### Google Cloud DNS

To get started:

* Ensure that your domain is hosted on Google Cloud DNS. You can move your existing domain to use the Cloud DNS
  by following this [guide](https://cloud.google.com/dns/docs/quickstart).

    !!! warning "Google Domains"
        [Google Domains](https://domains.google/#/) is a different product than Google Cloud DNS. The above guide
        gives directions on how to make a Google Domains hosted domain use the Google Cloud DNS

* Create a [service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) in JSON
  format.

* In the Cloudron dashboard, choose Google Cloud DNS from the drop down.

    <center>
    <img src="../img/domains-gcdns.png" class="shadow" width="500px">
    </center>

### Route53 DNS

To get started:

* Ensure the domain is hosted using AWS Route53. If not, you can follow this [guide](https://docs.aws.amazon.com/Route53/latest/DeveloperGuide/MigratingDNS.html) to migrate an existing domain to use the service.

* AWS has two forms of security credentials - root and IAM. When using root credentials on AWS, follow the instructions [here](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)
to create access keys. When using IAM, follow the instructions [here](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console)
  to create a user and use the following policy to give the user access to the domain. The `<hosted zone id>` below must
  be replaced with the zone's id which is available from the Route53 console.

```
    {
        "Version": "2012-10-17",
        "Statement": [
            {
                "Effect": "Allow",
                "Action": "route53:*",
                "Resource": [
                    "arn:aws:route53:::hostedzone/<hosted zone id>"
                ]
            },
            {
                "Effect": "Allow",
                "Action": [
                    "route53:ListHostedZones",
                    "route53:listHostedZonesByName",
                    "route53:GetChange"
                ],
                "Resource": [
                    "*"
                ]
            }
        ]
    }
```

* In the Cloudron dashboard, choose AWS Route53 from the drop down.

    <center>
    <img src="../img/domains-route53.png" class="shadow" width="500px">
    </center>

### Namecheap DNS

If your domain is registered with [Namecheap](https://www.namecheap.com), you can use Cloudron's Namecheap DNS backend to manage the DNS.

To get started:

* Enable API access for the Namecheap account (this is disabled by default). To do so, create an API key (Profile -> Tools) and whitelist your Cloudron's IP in
  the [Namecheap dashboard](https://ap.www.namecheap.com/settings/tools/apiaccess/).

!!! warning "Access error"
    It takes a few minutes for the IP whitelisting to take effect. If adding the domain in Cloudron gives an access error, wait a bit.

* If you intend to enable Cloudron Email for this domain, select `Custom MX` in the `MAIL SETTINGS` and set the MX record to be `my.example.com` (i.e the primary domain). Once set, Cloudron will keep this record updated accordingly.

    <center>
    <img src="../img/domains-namecheap-email.png" width="500px" class="shadow">
    </center>

* In the Cloudron dashboard, choose Namecheap from the drop down.

    <center>
    <img src="../img/domains-namecheap.png" width="500px" class="shadow">
    </center>

### Name.com DNS

If your domain is registered with [name.com](https://www.name.com), you can use Cloudron's Name.com DNS backend to manage the DNS.

To get started:

* Create a [name.com API token](https://www.name.com/account/settings/api)

* In the Cloudron dashboard, choose Name.com from the dropdown.

    <center>
    <img src="../img/domains-namedotcom.png" width="500px" class="shadow">
    </center>

### Wildcard DNS

If your domain is not hosted on any of the DNS providers supported by Cloudron, you can use the
Wildcard DNS backend.

To get started:

* Add a DNS A record with name `*.example.com` to point to your server's IP.

!!! Note "Wildcard entry has lower precedence"
    In DNS, a wildcard entry has lower precedence to subdomains that are explicitly defined. This means
    that if you already have a `blog.example.com` pointing to a different IP address, then it will
    be unaffected by the addition of this wildcard entry.

* (Optional) Add a DNS A record with name `example.com` to point to your server's IP. This is required
  only if you intend to host an app on the naked/bare domain (`example.com`) on the Cloudron.

* In the Cloudron dashboard, choose Wildcard from the dropdown.

    <center>
    <img src="../img/domains-wildcard.png" width="500px" class="shadow">
    </center>

* For sending email, Cloudron requires DKIM and SPF records to be setup as well. These records will
  be displayed in the UI after installation and have to be setup manually.

!!! Note "Let's Encrypt integration"
    Cloudron will use Let's Encrypt HTTP validation to procure certificates for apps. For this reason,
    you must open port 80 of your server when using the Wildcard provider.

### Manual DNS

If your domain is not hosted on any of the DNS providers supported by Cloudron, and you cannot use
the Wildcard DNS provider, then you can use the Manual DNS provider.

With the manual DNS provider, you have to setup DNS records prior to installing Cloudron and also
prior to installing each app. App installation will not succeed until DNS records are setup correctly.

If you are attempting to finish Cloudron setup:

* Set the `my` subdomain to the server's public IP

* Choose Manual from the DNS provider drop down

* For sending email, Cloudron requires DKIM and SPF records to be setup as well. These records will
  be displayed in the UI after installation and have to be setup manually.

* Remember to setup A records for subdomains to the server's public IP and then install apps.

!!! Note "Let's Encrypt integration"
    Cloudron will use Let's Encrypt HTTP validation to procure certificates for apps. For this reason,
    you must open port 80 of your server when using the Wildcard provider.

### No-op DNS

The No-op DNS backend disables Cloudron's DNS functionality and is intended to be used for testing and
development.

When using other DNS backends, Cloudron will setup the DNS automatically and also check if the DNS changes
have propagated. This prevents the user from hitting name resolution (NXDOMAIN) errors. When using the No-op
backend, the setup and checks are disabled and you are on your own to ensure that names are getting resolved
correctly.

## Zone Name

The DNS Zone Name is the domain name that is being managed by the DNS provider. By default, this value is the
top level domain like `example.com`. If the domain and subdomain are managed by different DNS providers, then provide
the zone name here.

For example, `example.com` might have been purchased at GoDaddy. You can delegate a subdomain like `internal.example.com`
to DigitalOcean by adding it in DigitalOcean and setting the NS records of `internal.example.com` to DigitalOcean DNS. In
such a situation, if you use `cloudron.internal.example.com` as the primary domain for Cloudron, the the zone name must
be set to `internal.example.com`.

## Changing the Dashboard domain

The Cloudron dashboard/admin UI is located at the `my` subdomain of the Cloudron's primary domain. The `my` subdomain
is hardcoded and cannot be changed. However, the primary domain can be changed from the `Domains` view.

Select the domain to move the dashboard into and click `Change Domain`. In a few minutes, you should be redirected to
the new location.

<center>
<img src="../img/domains-change-dashboard.png" width="500px" class="shadow">
</center>

!!! note "Notifications"
    The email server will be reconfigured to send notifications from the new primary domain.

!!! note "Unreachable dashboard"
    If your dashboard is unreachable, see the [troubleshooting section](/documentation/troubleshooting/#dashboard)

## DNS Errors

### DNS Record already exists

During app installation, Cloudron will setup a subdomain record. If the subdomain record already
exists, the app installation will error with the message `DNS Record already exists`. This check
is in place so that an existing website does not get overriden by mistake. This policy makes it
easy for Cloudron admins to use the same domain for Cloudron and for external non-Cloudron apps.

To use the subdomain, remove the entry manually in the DNS provider's website and re-install.

