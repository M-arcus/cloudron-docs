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

* Each Cloudron can optionally be pre-setup with a domain name like `customer.hostingprovider.com`. When
  customers install apps, they get installed into `<app>.customer.hostingprovider.com`.

* Automatic backups can be pre-configured to a location outside the Cloudron (Ceph, S3 etc).
  This provides an user experience close to managed hosting.

* Customer can add any number of custom domains of their own.

* Access to the server itself is locked down. Customers can only access the Cloudron web interface.
  Cloudron is designed so that customers never require SSH access.

* Access to all apps in the [Cloudron Appstore](/appstore.html).

* Automatic subscription - Your customers do not need to setup a subscription (credit card) with us
  Instead, you setup a billing account with us and you will charged based on our pricing agreement.
  Cloudrons are automatically subscribed to a plan that allows them to install any app they want.

## Installation

* Please reach out to [sales@cloudron.io](mailto:sales@cloudron.io) to get a license.

* Start with a fresh Ubuntu 18.04 64-bit server and run the following commands:

```
    wget https://cloudron.io/cloudron-setup
    chmod +x cloudron-setup
    ./cloudron-setup --provider generic --license <license>
```

* Reboot and snapshot the server. Please **do not finish the setup by visiting https://<IP>**.

* The above server snapshot can now be instantiated for each customer. Each customer can then visit `https://IP`
  to complete the installation. It is possible to pre-provision each customer Cloudron with a domain, backup configuration etc
  using the script below.

## Automatic provisioning

When the server snapshot is instantiated, the customer has to visit `https://IP` and complete the installation
by providing a domain name. As a hosting provider, you might want to provide your customers with a pre-setup domain
like `customer.hostingprovider.com`.

To achieve this, you can use the `cloudron-provision` script.

!!! "warning" Script must NOT be run on the snapshot
    The `cloudron-provision` must be run on the server instantiated from the snapshot. This is because the
    domain and backup configuration are unique to each customer.

### Domain setup

cloudron-provision domain <domain_config>

Once the script completes, the customer can reach Cloudron at `https://my-customer.hostingprovider.com`.

### Backup setup

cloudron-provision backup <backup_config>

## Customizations

Create a file named `/etc/cloudron/custom.yml`.

## Security

* The domain configuration (`dnsconfig`) of the domain is not visible to the customer.

* The backup configuration (`backupconfig`) is not visible to the customer.

* The wildcard TLS certs are not visible to the customer and are not part of the backups.

* Customers do not require SSH access to their servers for installing and managing apps.

* Each Customers' data is completely isolated to the VM.

