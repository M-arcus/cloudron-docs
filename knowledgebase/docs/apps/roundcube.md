# <img src="/documentation/img/roundcube-logo.png" width="25px"> Roundcube App

## Default Setup

Roundcube is pre-configured for use with Cloudron Email. 

## Multi-domain Setup

Users can login with their email and password to access their mailbox. If the
Cloudron has two domains, `example1.com` and `example2.com`, the user can login
using `user@example1.com` and `user@example2.com`. Aliases can be added as identities
under Roundcube settings.

## Vacation Email

An out of office / vacation mail message can be setup using Sieve filters.

A vacation message can be set in `Settings` -> `Filters` -> `Add filter` -> `Vacation message` action.

<center>
<img src="/documentation/img/email-vacation-message-roundcube.png" class="shadow" width="600px">
</center>

## Forwarding all emails

To forward all emails to an external mail, setup a Sieve filter in
`Settings` -> `Filters` -> `Add a filter` -> `Forward to`

<center>
<img src="/documentation/img/forward-all-emails-roundcube.png" class="shadow" width="600px">
</center>

## Plugins

[Plugins](https://plugins.roundcube.net/explore/) can be installed as follows:

* Extract the plugin using the [Web terminal](apps/#web-terminal) into
  `/app/data/plugins`.

* Change the ownership of the extracted plugin to `www-data`.

* Add the plugin to `$config['plugins']` in `/app/data/customconfig.php`.

