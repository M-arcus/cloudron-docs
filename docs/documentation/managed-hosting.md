# Managed Hosting

## What is Managed Cloudron

Managed Cloudron is a service offered by Cloudron.io that includes the hardware,
software, and ongoing upkeep of Cloudron on a virtual private server.

Managed Cloudrons run on [DigitalOcean](https://digitalocean.com) and use
[AWS S3](https://aws.amazon.com/s3/) for backups.

Managed Cloudrons are created on a subdomain of `cloudron.me` but they can be moved
to a [custom domain](#custom-domain).

## Custom domain

Managed Cloudrons can be moved to a custom domain like `example.com`. When using a custom
domain, the cloudron UI will become available at `my.example.com`. Apps will also be automatically
migrated to be available under subdomains like `git.example.com`, `blog.example.com` and so on.

To move to a custom domain:

* Click `Change` in the `Domains & Certs` menu item
* Select the DNS provider of your domain:

<center>
<img src="/img/custom-domain.png" class="shadow" width="600px">
</center>

* Cloudron supports the following DNS providers:
    *   [Cloudflare](/documentation/domains/#cloudflare-dns)
    *   [Digital Ocean](/documentation/domains/#cloudflare-dns)
    *   [Route53](/documentation/domains/#route-53-dns)
    *   [Wildcard](/documentation/domains/#wildcard-dns)

## Data retention policy

All data and backups of a managed Cloudron are deleted in 30 days. If you want it deleted
sooner, just let us know.

## Downloading backups

You can download all data and configuration whenever you want. Just drop us a note at
support@cloudron.io and we will provide you a link to download your backups.

## Mail server

Cloudron [mail server](/documentation/email/#how-cloudron-email-works) is available
when the Cloudron uses a [custom domain](#custom-domain).

