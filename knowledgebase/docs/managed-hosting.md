# Managed Hosting

## What is Managed Cloudron

Managed Cloudron is a service that offers Cloudron as a managed service.
It includes the hardware, software, and ongoing upkeep of Cloudron.

Some features of managed hosting are:

* We monitor the health of your apps and server
* Encrypted daily backups
* Hosted email with a custom domain
* Easily migrate to a larger instance
* No user limit and app count restrictions

## Pricing

Pricing information for Managed Cloudron is located [here](https://cloudron.io/managed.html).

## Infrastructure

Managed Cloudrons run on [DigitalOcean](https://digitalocean.com). Backups are
stored encrypted on [AWS S3](https://aws.amazon.com/s3/).

Managed Cloudrons run on a separate virtual servers for each customer. This has
the performance benefit that one Cloudron is unaffected by use by other customers.
It also adds a major security benefit (unlike shared web hosting) where your
data does not accidentally leak to other customers.

By virtue of it's single tenancy, each customer has their own IP that is
not shared with anyone else.

## Custom domain

Managed Cloudrons are created on a subdomain of `cloudron.me`. One or more custom
domains can be setup using the [domains](domains/) view.

## Privacy

Our privacy policy is laid out [here](https://cloudron.io/legal/privacy.html).

At a high level, Digital Ocean is our VPS provider and they are not in the business
of inspecting/collecting user information. We provide Cloudron as a service and not
in the business of inspecting/collecting user information. That said, since Digital Ocean
owns the server and Cloudron.io manages the server, both have access to the
server and can inspect the contents of the server (for example, the databases,
containers etc).

Unless there is a maintenence operation or an active alert (phishing/scam alert), we don't
access our customers' servers. Please read our [terms](https://cloudron.io/legal/terms.html)
for our policy on what kind of content is allows on our managed servers.

We also don't store or track any information "inside" the Cloudron. For example,
users/groups/domains/mailboxes etc are entirely local to the Cloudron server.

## Backups

Managed Cloudron keeps encrypted backups on S3 for the last 7 days.

Upon cancellation, all data and backups of a managed Cloudron are deleted in 30 days.

## Downloading backups

You can download all data and configuration whenever you want. Just drop us a note at
support@cloudron.io and we will provide you a link to download your backups.

