# <img src="/img/rainloop-logo.png" width="25px"> Rainloop App

## Default Setup

Rainloop is pre-configured for use with Cloudron Email. As such, Rainloop
has to be installed on a domain that has email enabled.

Users can login with their Cloudron username and password to access their
mailbox. Aliases can be added as indentities under the settings.

!!! note "Multiple domains"
    Cloudron does not support using the same rainloop installation for multiple
    domains.

## Vacation Email

An out of office / vacation mail message can be setup using Sieve filters.

A vacation message can be set in `Settings` -> `Filters` -> `Add a filter`. Choose
`Vacation message` action.

<center>
<img src="/img/email-vacation-message-rainloop.png" class="shadow" width="600px">
</center>

## Forwarding all emails

To forward all emails to an external mail, setup a Sieve filter in
`Settings` -> `Filters` -> `Add a filter` -> `Forward to`

<center>
<img src="/img/forward-all-emails-rainloop.png" class="shadow" width="600px">
</center>

## Admin panel

The admin panel is located at `/?admin` and is disabled by default.

To enable it, open a [Web terminal](/documentation/apps/#web-terminal)
and edit the file `/app/data/_data_/_default_/configs/application.ini`.
Set the value of `allow_admin_panel` to `On`. The default admin credentials
are:

    Username: admin
    Password: 12345


Restart the app for the changes to take effect.

We highly recommend disabling the admin panel after use. 
