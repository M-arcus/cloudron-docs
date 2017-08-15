# Managed Hosting

## What is Managed Cloudron

Each managed Cloudron consists of one or more virtual private servers. These private servers are not shared among our other users.

## Where do you host Cloudrons?
All Cloudrons are hosted on DigitalOcean, backups are stored on AWS S3. If you are a VPS/IaaS provider and would like to integrate Cloudron as part of your solution, please contact us support@cloudron.io.

## What is your data retention policy?

Once you delete your Cloudron, all data and backups will be gone in 30 days. If you want it deleted sooner, just let us know.

## Do I have full access to my data?

Absolutely. You can download all data and configuration whenever you want.

## Can I use a custom domain?

Yes! Currently, the only requirement is that you have to use Amazon Route53 as your nameserver. If you would like us to support others, please let us know.

Note that your existing DNS records are untouched. The Cloudron will only change the records you asked it to change (e.g app subdomains).

