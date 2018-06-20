# <img src="/documentation/img/confluence-logo.png" width="25px"> Confluence App

## Completing the installation

To finish the installation, do the following:

* Select Production Installation
* Add your license key.
* Select `PostgreSQL` as External Database.
* Choose `By connection string`.
* Use the [log viewer](https://cloudron.io/documentation/apps/#log-viewer) to get database settings.
  Look for a section called 'Datatabase Settings` in the logs.

## Adminstration check list

* Disable `Backup Confluence` Schedule Jobs. The Cloudron backups up confluence already.

* To enable LDAP, go to `Confluence Administration`:

    * `Users & Security` -> `User directories`
    * `Add Directory` -> `Internal with LDAP authentication`
    * Use the [log viewer](https://cloudron.io/documentation/apps/#log-viewer) to get LDAP settings.
    * You can make Cloudron users admin once they log in to Confluence and appear in user listing via LDAP

* To configure mail:

    * `Mail Servers` -> `Add SMTP mail`
    * Use the [log viewer](https://cloudron.io/documentation/apps/#log-viewer) to get SMTP settings.

## Oracle Java

OpenJDK is [not supported](https://confluence.atlassian.com/confkb/is-openjdk-supported-by-confluence-297667642.html)
by Confluence. For this reason, the Cloudron app uses Oracle Java.

