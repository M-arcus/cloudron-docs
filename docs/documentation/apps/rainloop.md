# <img src="/img/rainloop-logo.png" width="25px"> Rainloop App

## Vacation Email

An out of office / vacation mail message can be setup using Sieve filters.

A vacation message can be set in `Settings` -> `Filters` -> `Add filter` -> `Vacation message` action.

<center>
<img src="/img/email-vacation-message.png" class="shadow" width="600px">
</center>

## Forwarding all emails

To forward all emails to an external mail, setup a Sieve filter in
`Settings` -> `Filters` -> `Add a filter` -> `Forward to`

<center>
<img src="/img/forward-all-emails.png" class="shadow" width="600px">
</center>

### Admin panel

The admin panel is located at `/?admin` and is disabled by default.

To enable it, open a [Web terminal](/documentation/apps/#web-terminal)
and edit the file `/app/data/_data_/_default_/configs/application.ini`.
Set the value of `allow_admin_panel` to `On`. The admin username and
password can be set in the same file using the values `admin_login`
and `admin_password`.

Restart the app for the changes to take effect.

We highly recommend disabling the admin panel after use.

