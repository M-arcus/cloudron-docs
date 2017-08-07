# Install

## Install

Create a server with Ubuntu 16.04 (64-bit) and run these commands:
```
wget https://cloudron.io/cloudron-setup
chmod +x cloudron-setup
./cloudron-setup --provider <azure|digitalocean|ec2|linode|ovh|scaleway|vultr|generic>
```

!!! note "Minimum Requirements"
    Cloudron requires atleast 1GB RAM, 20GB Disk space. Make sure the firewall does not block port 80 (http)
    and 443 (https). Cloudron does not support ARM.

!!! tip "Referral codes"
    [DigitalOcean](https://m.do.co/c/933831d60a1e),
    [hosttech](https://www.hosttech.ch/?promocode=53619290), [Linode](https://www.linode.com/?r=f68d816692c49141e91dd4cef3305da457ac0f75),
    [Rosehosting](https://secure.rosehosting.com/clientarea/?affid=661), [Vultr](http://www.vultr.com/?ref=7110116-3B).

## Domain Setup

Once the installation is complete, navigate to `https://<IP>` and accept the self-signed certificate.

Provide a [second level domain](https://en.wikipedia.org/wiki/Second-level_domain) like `smartserver.io`
for the Cloudron. Cloudron will install apps as subdomain of this domain. It is safe to use a
domain name that is already in use.

If you choose one of the programmable DNS backends like Route53, Digital Ocean or Cloudflare, the
Cloudron will automatically make changes to DNS as and when required.

During installation, Cloudron makes the following changes to DNS:

*   Sets the `my` subdomain to the server's public IP

*   Sets `cloudron._domainkey` TXT record to the public DKIM key (required for sending emails)

*   Modifies the SPF record to permit `my` subdomain (required for sending emails)

!!! note "Third level domain installation"
    Cloudron can also be installed on a non-registrable domain like `cloudron.example.com`
    with an Enterprise subscription. This allows for setups where you can host
    Cloudrons under the same top level domain for each of your customers like `customer1.myhosting.com`,
    `customer2.myhosting.com` and so on.

### Cloudflare DNS

Use the [Global API Key](https://support.cloudflare.com/hc/en-us/articles/200167836-Where-do-I-find-my-CloudFlare-API-key-)
available in the profile section of your account.


### Digital Ocean DNS

Create an [APIv2 token](https://www.digitalocean.com/community/tutorials/how-to-use-the-digitalocean-api-v2)
with read+write access.

### Route 53 DNS

When using root credentials on AWS, follow the instructions [here](http://docs.aws.amazon.com/general/latest/gr/managing-aws-access-keys.html)
to create access keys.

When using IAM, follow the instructions [here](http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html#id_users_create_console) to create a user and use the following policy to give the user access to your domain's Route53.
The `<hosted zone id>` below must be replaced with your zone's id which is available from the Route53 console.

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
For sending email, Cloudron requires DKIM and SPF records to be setup as well. These records will
be displayed in the UI post installation.

## Administrator Setup

Once you enter the DNS credentials, Cloudron will get a certificate via Let's Encrypt
and redirect to `https://my.<domain>`. The browser address bar will show a green lock to indicate
that the connection to your Cloudron is now secure.

Enter the adminstrator username, email and password for the Cloudron. Some usernames like `admin`
are unfortunately reserved because apps attach special meanings to them.

The email id you enter here is used for password recovery and not sent anywhere (including cloudron.io).

!!! warning "Let's Encrypt requires a valid email"
    Cloudron will setup a Let's Encrypt account with the administrator's email. If this email
    is not valid, Let's Encrypt will not issue certificates.

## Cloudron Store Setup

You are now ready to start installing apps! When you click on the `App Store` link in the UI,
you will be prompted to create a [cloudron.io](https://cloudron.io) account. This account is
used to manage your subscription & billing.

## Community

Please join our <a href="https://chat.cloudron.io" target="_blank">chat</a> for any questions.

