# Welcome

## Installation

Create a server with Ubuntu 16.04 (64-bit) and run these commands:
```
wget https://cloudron.io/cloudron-setup
chmod +x cloudron-setup
./cloudron-setup --provider <azure|digitalocean|ec2|linode|ovh|scaleway|vultr|generic>
```

<small>**Minimum server requirements**: 1GB RAM, 20GB Disk space. Cloudron does not support ARM
(Raspberry Pi, Beagle board etc).</small>

<small>**Referral codes:**: [Amazon EC2](https://aws.amazon.com/ec2/), [DigitalOcean](https://m.do.co/c/933831d60a1e),
[hosttech](https://www.hosttech.ch/?promocode=53619290), [Linode](https://www.linode.com/?r=f68d816692c49141e91dd4cef3305da457ac0f75),
[Rosehosting](https://secure.rosehosting.com/clientarea/?affid=661), [Vultr](http://www.vultr.com/?ref=7110116-3B)
</small>

<small>For Kimsufi, be sure to check the "use the distribution kernel" checkbox in the personalized installation mode.</small>

## Domain Setup

Navigate to `https://<IP>` and accept the self-signed certificate.

Provide a [second level domain](https://en.wikipedia.org/wiki/Second-level_domain) like `girish.in`
for the Cloudron. If you want to install Cloudron on a non-registrable domain like `cloudron.example.com`,
you must purchase an Enterprise subscription. This allows for setups where you can host
multiple Cloudrons under the same top level domain like `customer1.company.com`,
`customer2.company.com` and so on.

Cloudron installs apps as subdomain of this domain. It is safe to use an 
_existing_ domain name that is in use. Cloudron only makes the following changes to DNS:

*   Sets the `my` subdomain to the server's public IP

*   Sets `cloudron._domainkey` TXT record to the public DKIM key (required for outbound emails)

*   Adds `my` subdomain to the SPF record (required to send outbound emails)

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

## Administrator Setup

## Appstore Setup

## Shortcuts

<div class="shortcuts">
<a href="https://git.cloudron.io/cloudron/box/issues" target="_blank">
    <br/><i class="fa fa-bug fa-3x"></i><br/>
    Report an Issue
</a><a href="/knowledge-base/CLI/">
    <br/><i class="fa fa-terminal fa-3x"></i><br/>
    CLI Tool
</a><a href="/references/manifest/">
    <br/><i class="fa fa-file-text-o fa-3x"></i><br/>
    Manifest File
</a><a href="/references/addons/">
    <br/><i class="fa fa-puzzle-piece fa-3x"></i><br/>
    Addons
</a><a href="/references/baseimage/">
    <br/><i class="fa fa-dot-circle-o fa-3x"></i><br/>
    Base Image
</a>
</div>
