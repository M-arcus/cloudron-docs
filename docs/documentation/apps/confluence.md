# <img src="/img/confluence-logo.png" width="25px"> Confluence App

## Completing the installation

To finish the installation, do the following:

* Select Production Installation
* Add your license key.
* Select `PostgreSQL` as External Database.
* Choose 'Direct JDBC`.
* Use the [cloudron logs](https://git.cloudron.io/cloudron/cloudron-cli) to get database settings.

## Adminstration check list

* Disable `Backup Confluence` Schedule Jobs. The Cloudron does this already.

* To enable LDAP:

    * `User Administration` -> `User directories`
    * `Add Directory` -> `Internal with LDAP authentication`
    * Use the [cloudron logs](https://git.cloudron.io/cloudron/cloudron-cli) to get LDAP settings
    * You can make users admin once they log in and appear in user listing via LDAP

* To configure mail:

    * `Mail Servers` -> `Add SMTP mail`
    * Use the [cloudron logs](https://git.cloudron.io/cloudron/cloudron-cli) to get SMTP settings

## Oracle Java

OpenJDK is [not supported](https://confluence.atlassian.com/confkb/is-openjdk-supported-by-confluence-297667642.html)
by Confluence. For this reason, the Cloudron app uses Oracle Java.

