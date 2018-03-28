# Managed Hosting

## What is Managed Cloudron

Managed Cloudron is a service that offers Cloudron as a managed service.
It includes the hardware, software, and ongoing upkeep of Cloudron.

Managed Cloudrons run on [DigitalOcean](https://digitalocean.com) and use
[AWS S3](https://aws.amazon.com/s3/) for backups.

## Custom domain

Managed Cloudrons are created on a subdomain of `cloudron.me`. One or more custom
domains can be setup using the [domains](domains/) view.

## Backups

Managed Cloudron keeps backups of the last 7 days.

## Data retention policy

Upon cancellation, all data and backups of a managed Cloudron are deleted in 30 days.

## Downloading backups

You can download all data and configuration whenever you want. Just drop us a note at
support@cloudron.io and we will provide you a link to download your backups.
