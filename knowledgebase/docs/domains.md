# Domains

## Managing domains

The `Domains` view can be used to add a domain for use by the Cloudron. Once added,
apps can be installed as subdomains of the added domain. The
[Cloudron Email Server](email/) can also be enabled on a per-domain basis.

<center>
<img src="../img/domains.png" class="shadow" width="600px">
</center>

To add a domain, one must select from one of the following DNS services in which
the domain is hosted:

*   [AWS Route53](domains/#route-53-dns)
*   [Cloudflare](domains/#cloudflare-dns)
*   [Digital Ocean](domains/#cloudflare-dns)
*   [Gandi LiveDNS](domain/#gandi)
*   [GoDaddy](domain/#godaddy)
*   [Google Cloud DNS](domain/#google-cloud-dns)
*   [Wildcard](domains/#wildcard-dns)

The idea is that (when using one of the programmable backends) Cloudron will automatically make
changes to DNS as and when required.

!!! note "Common domain registrars"
    You can always purchase a domain from any of the common domain registrars
    like Namecheap, Name.com, Gandi and <a href="https://www.digitalocean.com/community/tutorials/how-to-point-to-digitalocean-nameservers-from-common-domain-registrars" target="_blank">setup your domain's nameservers</a> to use one of the above DNS services.

## DNS setup

Cloudron automates the DNS setup required using the APIs provided by DNS providers like
Cloudflare, Digital Ocean and Route53.

During installation, Cloudron makes the following changes to DNS:

*   Sets the `my` subdomain to the server's public IP

*   Sets `cloudron._domainkey` TXT record to the public DKIM key (required for sending emails)

*   Modifies the SPF record to permit `my` subdomain (required for sending emails)

When [email](email/) is enabled, Cloudron makes the following changes to DNS:

*   Sets the `MX` record to the `my` subdomain
*   Sets the `DMARC` policy to reject all emails not originating from the Cloudron for this domain.

For Cloudrons using a non-programmable DNS backend, the DNS records will be displayed in the UI so
that they can be setup manually.

### Cloudflare DNS

Use the [Global API Key](https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-CloudFlare-API-key-)
available in the profile section of your account.

<center>
<img src="../img/domains-cloudflare.png" class="shadow" width="500px">
</center>

!!! warning "Cloudflare HTTP(S) proxy"
    Cloudron does not support installing apps that are proxied via Cloudflare. Cloudflare backend
    only sets up the DNS via Cloudflare API and expects website traffic to be unproxied.

### Digital Ocean DNS

Create an [APIv2 token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2)
with read+write access.

<center>
<img src="../img/domains-digitalocean.png" class="shadow" width="500px">
</center>

### Gandi LiveDNS

[LiveDNS](http://doc.livedns.gandi.net/) is Gandi.net's DNS platform, a completely new service that offers
its own API and its own nameservers.

If your domain is registered with Gandi, you can use Cloudron's new Gandi DNS backend to manage the DNS.
When apps are installed and removed, Cloudron will automatically add and remove DNS records. When using
Cloudron Email, it will also automatically setup the MX, DMARC, DKIM records!

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

[GoDaddy](https://www.godaddy.com) is the world's largest registrar.

If your domain is registered with GoDaddy, you can use Cloudron's new GoDaddy DNS backend to manage the DNS.
When apps are installed and removed, Cloudron will automatically add and remove DNS records. When using
Cloudron Email, it will also automatically setup the MX, DMARC, DKIM records!

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

Create a [service account key](https://cloud.google.com/iam/docs/creating-managing-service-account-keys) in JSON
format.

<center>
<img src="../img/domains-gcdns.png" class="shadow" width="500px">
</center>

### Route 53 DNS

When using root credentials on AWS, follow the instructions [here](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)
to create access keys.

<center>
<img src="../img/domains-route53.png" class="shadow" width="500px">
</center>

When using IAM, follow the instructions [here](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console) to create a user and use the following policy to give the user access to the domain.
The `<hosted zone id>` below must be replaced with the zone's id which is available from the Route53 console.

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
                "route53:GetChange"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
```

### Wildcard DNS

For wildcard setup, add entries for `*.domain.com` and `domain.com` to point to your server's IP.
Note that adding add wildcard entry does _not_ affect any existing DNS entries in `domain.com`
because the wildcard only applies to subdomains that are not explicitly defined.

For sending email, Cloudron requires DKIM and SPF records to be setup as well. These records will
be displayed in the UI after installation.

## Changing the Dashboard domain

The Cloudron dashboard/admin UI is located at the `my` subdomain. The `my` subdomain is hardcoded
and cannot be changed. However, the domain under which it is available can be changed as follows:

* Add the new domain in the `Domains` view.

* Edit `/home/yellowtent/configs/cloudron.conf`
    * Change `adminFqdn` to the domain added above
    * Change `adminFqdn` to `my.example.com`

    !!! warning "Do not change adminLocation"
        The `adminLocation` seems to be customizable but changing this to any value other than `my`
        will break the installation

* If you used the `wildcard` or `manual` DNS backend, add a DNS `A` record manually
  for `*.example.com` and `example.com` to the server's IP. For, `route53`, `cloudflare`, `gcdns`
  `digitalocean` and other automated DNS backends, you can skip this step.

* Run the following command to update the OAuth endpoint:
    ```
        mysql -uroot -ppassword --database=box -e "UPDATE clients SET redirectURI='https://my.domain.com' WHERE type='built-in'"
    ```
* Run the command `systemctl restart box`

In a few minutes, you should be able to reach `https://my.example.com`.

## DNS Errors

### DNS Record already exists

During app installation, Cloudron will setup a subdomain record. If the subdomain record already
exists, the app installation will error with the message `DNS Record already exists`. This check
is in place so that an existing website does not get overriden by mistake. This policy makes it
easy for Cloudron admins to use the same domain for Cloudron and for external non-Cloudron apps.

To use the subdomain, remove the entry manually in the DNS provider's website and re-install.

## Recreating DNS Records

If DNS records for Cloudron apps or the email solution are lost or accidentally deleted on the nameserver,
then they can be easily recreated or resetup by the Cloudron if one of the automated DNS backends
([Route53](#route53-dns), [DigitalOcean](#digital-ocean-dns) or [Cloudflare](#cloudflare-dns)) is used.

### Recreating App DNS Record

For apps, simply [reconfigure](apps/#re-configuring-an-app) the app without changing any of the settings. This will ensure the DNS records
are setup correctly and thus will recreate them. In case they exist but are wrong, they have to be manually deleted first.

### Recreating Email DNS Records

In order to recreate all Email related DNS records, the main Cloudron service has to be restarted.
While restarting it will ensure all records are correct and in-sync on all nameservers.

Connect via ssh to your server and run the following command:
```
systemctl restart box
```
