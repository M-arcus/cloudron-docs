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

## Finishing setup

Navigate to `https://<IP>` and provide a [second level domain](https://en.wikipedia.org/wiki/Second-level_domain)
like `girish.in` for the Cloudron. Cloudron installs apps as subdomain of this domain. It is safe to use an 
_existing_ domain name that is in use.

Cloudron makes the following changes to DNS:

*   Sets the `my` subdomain to the server's public IP

*   Sets `cloudron._domainkey` TXT record to the public DKIM key (required for outbound emails)

*   Adds `my` subdomain to the SPF record (required to send outbound emails)

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
