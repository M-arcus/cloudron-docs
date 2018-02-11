# <img src="/img/roundcube-logo.png" width="25px"> Roundcube App

## Default Setup

Roundcube is pre-configured for use with Cloudron Email. As such, Roundcube
has to be installed on a domain that has email enabled.

Users can login with their Cloudron username and password to access their
mailbox. Aliases can be added as indentities under the settings.

!!! note "Multiple domains"
    Cloudron does not support using the same roundcube installation for multiple
    domains.

## Vacation Email

An out of office / vacation mail message can be setup using Sieve filters.

A vacation message can be set in `Settings` -> `Filters` -> `Add filter` -> `Vacation message` action.

<center>
<img src="/img/email-vacation-message-roundcube.png" class="shadow" width="600px">
</center>

## Forwarding all emails

To forward all emails to an external mail, setup a Sieve filter in
`Settings` -> `Filters` -> `Add a filter` -> `Forward to`

<center>
<img src="/img/forward-all-emails-roundcube.png" class="shadow" width="600px">
</center>

## Plugins

[Plugins](https://plugins.roundcube.net/explore/) can be installed as follows:

* Extract the plugin using the [Web terminal](/documentation/apps/#web-terminal) into
  `/app/data/plugins`.

* Change the ownership of the extracted plugin to `www-data`.

* Add the plugin to `$config['plugins']` in `/app/data/customconfig.php`.

