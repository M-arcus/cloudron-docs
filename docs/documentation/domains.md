# DNS

## DNS setup

Cloudron automates the DNS setup required using the APIs provided by DNS providers like
Cloudflare, Digital Ocean and Route53.

During installation, Cloudron makes the following changes to DNS:

*   Sets the `my` subdomain to the server's public IP

*   Sets `cloudron._domainkey` TXT record to the public DKIM key (required for sending emails)

*   Modifies the SPF record to permit `my` subdomain (required for sending emails)

When [email](/documentation/email/) is enabled, Cloudron makes the following changes to DNS:

*   Sets the `MX` record to the `my` subdomain
*   Sets the `DMARC` policy to reject all emails not originating from the Cloudron for this domain.

For Cloudrons using a non-programmable DNS backend, the DNS records will be displayed in the UI so
that they can be setup manually.

## Cloudflare DNS

Use the [Global API Key](https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-CloudFlare-API-key-)
available in the profile section of your account.


## Digital Ocean DNS

Create an [APIv2 token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2)
with read+write access.

## Route 53 DNS

When using root credentials on AWS, follow the instructions [here](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)
to create access keys.

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

## Wildcard DNS

For wildcard setup, add entries for `*.domain.com` and `domain.com` to point to your server's IP.
Note that adding add wildcard entry does _not_ affect any existing DNS entries in `domain.com` 
because the wildcard only applies to subdomains that are not explicitly defined.

For sending email, Cloudron requires DKIM and SPF records to be setup as well. These records will
be displayed in the UI after installation.

## DNS Errors

### DNS Record already exists

During app installation, Cloudron will setup a subdomain record. If the subdomain record already
exists, the app installation will error with the message `DNS Record already exists`. This check
is in place so that an existing website does not get overriden by mistake. This policy makes it
easy for Cloudron admins to use the same domain for Cloudron and for external non-Cloudron apps.

To use the subdomain, remove the entry manually in the DNS provider's website and re-install.

### Recreate DNS Records

If DNS records for Cloudron apps or the email solution are lost or accidentally deleted on the nameserver,
then they can be easily recreated or resetup by the Cloudron if one of the automated DNS backends
([Route53](#route53-dns), [DigitalOcean](#digital-ocean-dns) or [Cloudflare](#cloudflare-dns)) is used.

#### Recreate App DNS Record

For apps, simply [reconfigure](/documentation/apps/#re-configuring-an-app) the app without changing any of the settings. This will ensure the DNS records
are setup correctly and thus will recreate them. In case they exist but are wrong, they have to be manually deleted first.

#### Recreate Email DNS Records

In order to recreate all Email related DNS records, the main Cloudron service has to be restarted.
While restarting it will ensure all records are correct and in-sync on all nameservers.

Connect via ssh to your server and run the following command:
```
systemctl restart box
```
