# Hosting Edition

## About

Cloudron Hosting Edition is targeted at Cloud service providers and Web hosting
providers who would like to offer Cloudron for their customers. With the
Cloudron Hosting Edition, Cloud service providers can offer Cloudron to their
customers to effortlessly install and run app like Wordpress, Nextcloud, GitLab and OpenVPN.

## Deployment model

Cloudron can be deployed in a dedicated server, virtual private server or a virtual
machine. Each Cloudron installation is designed to be single tenant - a separate install
for each customer. Domains, Apps and Users added in a single Cloudron installation 
are expected to be of the same customer/team/organization.

**Cloudron is not designed for shared web hosting style setups** where you can create
a single Cloudron installation and add multiple customers as users in the same installation.

## Cloudron Editions

Cloudron comes in 2 flavors - The `Server Edition` and the `Hosting Edition`.

### Server Edition

The `Server Edition` can be installed using the standard [install script](/get.html).
Once installation is complete, you can snapshot the server and can provide it to your customers.
Customers can then create a server from the snapshot and complete the installation.

### Hosting Edition 

In addition to all features of the `Server Edition`, the `Hosting Edition` adds
the following:

* **Bulk licensing and automatic subscription** - With this, you can pre-provision cloudron installations with a license. This
  way, your customers do not have to setup a billing account us. Instead, you will charged based on our pricing agreement.
  Bulk licenses have access to all apps in the [App Store](/appstore.html).

* **Pre-setup domain and backup configuration** - Each Cloudron can be pre-setup with a domain name like `customer.hostingprovider.com`.
  Each Cloudron can be pre-configured to backup to a location outside the Cloudron (Ceph, S3 etc).
  This automation provides an user experience close to managed hosting.

* **Whitelabeling and customization** - It's possible to white label the UI with your branding and customize some pages like
  the Support page.

## Installation

* Please reach out to [sales@cloudron.io](mailto:sales@cloudron.io) to get a trial license.

* Start with a fresh Ubuntu 18.04 64-bit server and run the following commands:

```
    wget https://cloudron.io/cloudron-setup
    chmod +x cloudron-setup
    ./cloudron-setup --provider generic --license <license>
```

* Reboot and snapshot the server. Please **do not finish the setup by visiting https://IP**.

* The above server snapshot can now be instantiated for each customer. Each customer can then visit `https://IP`
  to complete the installation. To pre-setup a domain, see the section below.

## Automatic provisioning

When the server snapshot is instantiated, the customer has to visit `https://IP` and complete the installation
by providing a domain name. As a hosting provider, you might want to provide your customers with a pre-setup domain
like `customer.hostingprovider.com`.

To achieve this, you can use the `cloudron-sysadmin` script. This script can be installed using:

```
sudo npm install -g cloudron-sysadmin
```

!!! warning "Script must NOT be run on the snapshot"
    The `cloudron-sysadmin` must be run on the server instantiated from the snapshot. This is because the
    domain and backup configuration are unique to each customer.

Run the following command (from your PC/Laptop):

```
cloudron-sysadmin setup-dns --ip <server_ip> --domain-name <customer.hostingprovider.com> --dns-zone <hostingprovider.com> --dns-provider <provider> --dns-config <dns_config> --backup-config <backup_config>
```

Once the script completes, the customer can reach the Cloudron at `https://my.customer.hostingprovider.com`.

## Customization

Create a file named `/etc/cloudron/custom.yml`. Uncomment and customize as neeeded.

```
# add customizations here
# after making changes run "sudo systemctl restart box"

# backups:
#   configurable: true
#
# domains:
#   dynamicDns: true
#   changeDashboardDomain: true
#
# subscription:
#   configurable: true
#
# support:
#   email: support@cloudron.io
#   remoteSupport: true
#
#   ticketFormBody: |
#     Use this form to open support tickets. You can also write directly to [support@cloudron.io](mailto:support@cloudron.io).
#       * [Knowledge Base & App Docs](https://cloudron.io/documentation/apps/?support_view)
#       * [Custom App Packaging & API](https://cloudron.io/developer/packaging/?support_view)
#       * [Forum](https://forum.cloudron.io/)
#
#   submitTickets: true
#
# alerts:
#   email: support@cloudron.io
#   notifyCloudronAdmins: false
#
# footer:
#   body: '&copy; 2019 [Cloudron](https://cloudron.io) [Forum <i class="fa fa-comments"></i>](https://forum.cloudron.io)'

```

## Security

* Each Customers' data is completely isolated to the VM.

* Customers do not require SSH access to their servers for installing and managing apps. If you give SSH access to customers,
  then please be aware that they can access the database to view any pre-setup domain and backup configuration.

* Any pre-setup domain and backup configuration is locked and not configurable by the customer.

