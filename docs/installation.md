# Welcome

## Installation

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
    [Amazon EC2](https://aws.amazon.com/ec2/), [DigitalOcean](https://m.do.co/c/933831d60a1e),
    [hosttech](https://www.hosttech.ch/?promocode=53619290), [Linode](https://www.linode.com/?r=f68d816692c49141e91dd4cef3305da457ac0f75),
    [Rosehosting](https://secure.rosehosting.com/clientarea/?affid=661), [Vultr](http://www.vultr.com/?ref=7110116-3B).

!!! attention "Kimsufi"
    Be sure to check the "use the distribution kernel" checkbox in the personalized installation mode.

## Domain Setup

Navigate to `https://<IP>` and accept the self-signed certificate.

Provide a [second level domain](https://en.wikipedia.org/wiki/Second-level_domain) like `girish.in`
for the Cloudron. Cloudron will install apps as subdomain of this domain. It is safe to use an 
domain name that is already in use. Cloudron only makes the following changes to DNS:

*   Sets the `my` subdomain to the server's public IP

*   Sets `cloudron._domainkey` TXT record to the public DKIM key (required for outbound emails)

*   Adds `my` subdomain to the SPF record (required to send outbound emails)

!!! note "Third level domain requires Enterprise subscription"
    Cloudron can also be installed on a non-registrable domain like `cloudron.example.com`
    with an Enterprise subscription. This allows for setups where you can host
    multiple Cloudrons under the same top level domain like `customer1.company.com`,
    `customer2.company.com` and so on.

### Route 53

* For root credentials:
    * In AWS Console, under your name in the menu bar, click `Security Credentials`
    * Click on `Access Keys` and create a key pair.
* For IAM credentials:
    * You can use the following policy to create IAM credentials:

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

### Digital Ocean

Create an API token with read+write access and choose `Digital Ocean` as the DNS provider.

### Cloudflare

Create an API token

### Wildcard

!!! success "Successful setup"
    Once you enter the DNS credentials, Cloudron will get a certificate via Lets Encrypt
    and redirect to `https://my.<domain>`.

## Administrator Setup

Enter the adminstrator username and password for the Cloudron. The email id you enter here
will be used for password recovery if you lose the password.

!!! warning "Let's Encrypt requires a valid email"
    Cloudron will setup a Let's Encrypt account with the administrator's email. If this email
    is not valid, Let's Encrypt will not issue certificates.

## Appstore Setup

You are now ready to start installing apps! When you click on the 'App Store' link in the UI,
you will be prompted to create a [cloudron.io](https://cloudron.io) account. This account is
used to manage your subscription & billing.

