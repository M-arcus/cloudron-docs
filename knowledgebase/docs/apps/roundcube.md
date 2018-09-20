# <img src="/documentation/img/roundcube-logo.png" width="25px"> Roundcube App

## Default Setup

Roundcube is pre-configured for use with Cloudron Email. 

## Multi-domain Setup

Users can login with their email and password to access their mailbox. If the
Cloudron has two domains, `example1.com` and `example2.com`, the user can login
using `user@example1.com` and `user@example2.com`. Aliases can be added as identities
under Roundcube settings.

## External domains

The roundcube app does not support adding domains that are not managed in Cloudron.
Consider using the [rainloop app](/documentation/apps/rainloop) as an alternative.

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

* Change the ownership of the extracted plugin to `www-data` by running the command
  `chown -R www-data:www-data /app/data/plugins`.

* Add the plugin to `$config['plugins']` in `/app/data/customconfig.php`:
```
    array_push($config['plugins'], 'myplugin');
```

### Enabling PGP support

The Enigma plugin can be used to enable PGP support. The Enigma plugin is part of the
roundcube code and no installation is required. To enable the plugin:

* Open a [Web terminal](apps/#web-terminal)

* Add the following lines to `/app/data/customconfig.php`:
```
    array_push($config['plugins'], 'enigma');
    $config['enigma_pgp_homedir'] = '/app/data/enigma';
```

* Create the directory where enigma will save the PGP keys on the server:
```
    mkdir /app/data/enigma
    chown www-data:www-data /app/data/enigma
```
* New PGP keys can be created or existing ones can be imported in `Settings` -> `PGP Keys`

<center>
<img src="/documentation/img/roundcube-pgp-settings.png" class="shadow" width="600px">
</center>


* When composing new mail, you will see an Encryption icon in the tool bar.

<center>
<img src="/documentation/img/roundcube-encryption-icon.png" class="shadow" width="600px">
</center>

## Changing the title

* Open a [Web terminal](apps/#web-terminal)

* Add the following lines to `/app/data/customconfig.php`:

```
$rcmail_config['product_name'] = 'My Hosting Company';
```

## Skins

[Skins](https://plugins.roundcube.net/explore/) can be installed as follows:

* Extract the skin using the [Web terminal](apps/#web-terminal) into
  `/app/data/skins`.

* Change the ownership of the extracted skin to `www-data` by running the command
  `chown -R www-data:www-data /app/data/skins`.

* Set the new skin as the default skin in `/app/data/customconfig.php`:

```
    $rcmail_config['skin'] = 'mycustomskin';
```


