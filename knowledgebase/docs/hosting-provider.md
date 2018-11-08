# Hosting Provider Edition

Cloudron Hosting Provider Edition is targeted at Cloud service providers and Web hosting
providers who would like to offer Cloudron for their customers.

The Hosting Provider Edition functions similar to the standard Cloudron but includes the
following features:

* Each of your customers have a separate Cloudron installation. This way a service provider
  can individually provision servers with the necessary CPU/RAM/Disk resources based on
  customer requirements.

* Each Cloudron is pre-setup with a domain name like `customer.hostingprovider.com`. When
  customers install apps, they get installed into `<app>-customer.hostingprovider.com`.

* Pre-setup with backup configuration so customers don't have to configure it themselves.

* Customer can add any number of domains of their own.

* Access to the server itself is locked down. Customers can only access the Cloudron web interface.

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

To prepare the Cloudron for the customer, create a server with the above snapshot and then
activate it using the [provision script](https://git.cloudron.io/cloudron/box/blob/master/scripts/cloudron-provision):

```
cloudron-provision --ip <serverip> --zone <zone> --subdomain <customer> --dns-config <dnsconfig> --license <license>
```

The parameters are:
* `serverip` - The IP Address of the newly created server
* `zone` - A domain name for the Cloudron install like `hostingprovider.com`.
* `customer` - The subdomain/id that is unique across all customers. The Cloudron will use `customer.hostingprovider.com` as the subdomain for hosting the customer apps.
* `dnsconfig` - Information on how to configure the `hostingprovider.com` DNS.
    * For Cloudflare, this will be `{ "provider": "cloudflare", "email": "cfemail", "token": "cftoken" }`
* `license` - Licensing information (contact support@cloudron.io to get this information)

Once the script completes, the customer can reach Cloudron at `https://my-customer.hostingprovider.com`.

## Security

* The domain configuration (`dnsconfig`) of the domain is not visible to the customer.

* Customers cannot and do not require SSH access to their servers for installing and managing apps.

* Each Customers' data is completely isolated to the VM.

