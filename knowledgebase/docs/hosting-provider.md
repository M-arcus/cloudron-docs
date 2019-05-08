# Hosting Provider Edition

## About

Cloudron Hosting Provider Edition is targeted at Cloud service providers and Web hosting
providers who would like to offer Cloudron for their customers. With the
Cloudron Hosting Provider Edition, customer can effortlessly install and run app like
Wordpress, Nextcloud, GitLab and OpenVPN. Cloudron takes care of keeping these apps
up-to-date while the service provider takes care of the server management.

## Features

The Hosting Provider Edition functions similar to the standard Cloudron but includes the
following features:

* Each of your customers have a separate Cloudron installation. This way a service provider
  can individually provision servers with the necessary CPU/RAM/Disk resources based on
  customer requirements.

* Each Cloudron is pre-setup with a domain name like `customer.hostingprovider.com`. When
  customers install apps, they get installed into `<app>-customer.hostingprovider.com`.

* Automatic backups can be pre-configured to a location outside the Cloudron (Ceph, S3 etc).
  This provides an user experience close to managed hosting.

* Customer can add any number of custom domains of their own.

* Access to the server itself is locked down. Customers can only access the Cloudron web interface.
  Cloudron is designed so that customers never require SSH access.

* Access to all apps in the [Cloudron Appstore](/appstore.html).

## Installation

* Start with a fresh Ubuntu 18.04 64-bit server and run the following commands:

```
    wget https://cloudron.io/cloudron-setup
    chmod +x cloudron-setup
    ./cloudron-setup --provider generic --edition hostingprovider
```

* Snapshot the server. This server snapshot can then be instantiated on demand and provisioned
  with the activation script for each customer.

## Activation

To prepare Cloudron for the customer, create a server with the above snapshot and then
activate it using the [provision script](https://git.cloudron.io/cloudron/box/raw/master/scripts/cloudron-provision):

```
cloudron-provision --ip <serverip> \
    --dns-config <dnsconfig> \
    --backup-config <backupconfig> \
    --tls-cert <tlscertfile> \
    --tls-key <tlskeyfile> \
    --license <license>
```

The parameters are:

* `serverip` - The IP Address of the newly created server
* `dnsconfig` - Information on how to configure the DNS. The domain/id here (`customer.hostingprovider.com`) must be unique across all customers.
    * For Cloudflare, this will be `{ "domain": "customer.hostingprovider.com", "provider": "cloudflare", "config": { "email": "cfemail", "token": "cftoken", "hyphenatedSubdomains": true } }`
* `backupconfig` - Information on how to backup the Cloudron installation.
* `tlscertfile`, `tlskeyfile` - File containing a wildcard cert and key for `*.hostingprovider.com`.
* `license` - Licensing information (contact support@cloudron.io to get this information)

Once the script completes, the customer can reach Cloudron at `https://my-customer.hostingprovider.com`.

## Security

* The domain configuration (`dnsconfig`) of the domain is not visible to the customer.

* The backup configuration (`backupconfig`) is not visible to the customer.

* The wildcard TLS certs are not visible to the customer and are not part of the backups.

* Customers do not require SSH access to their servers for installing and managing apps.

* Each Customers' data is completely isolated to the VM.


## Demo

There is a [live demo](https://my.demo.cloudron.io) at `https://my.demo.cloudron.io` (username: cloudron password: cloudron).

In the demo installation, the base domain is `cloudron.me`. The customer specific subdomain is `demo`.

