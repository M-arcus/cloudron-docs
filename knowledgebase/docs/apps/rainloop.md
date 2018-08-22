# <img src="/documentation/img/rainloop-logo.png" width="25px"> Rainloop App

## Default Setup

Rainloop is pre-configured for use with Cloudron Email. The app automatically
generates domain configuration for all the apps that have email enabled at
_installation_ time. If you enable or disable email on one or more domains,
simply reconfigure the app and it will re-generate the necessary configuration.

## Multi-domain Setup

There are two ways to use Rainloop when using Cloudron Email with multiple
domains.

* Users can login with their email and password to access their mailbox. If the
  Cloudron has two domains, `example1.com` and `example2.com`, the user can login
  using `user@example1.com` and `user@example2.com`. Aliases can be added as identities
  under Rainloop settings.

* Users can login using one of the email domains and add the other domains
  using the `Add Account` dialog. For example, user can login as `user@example1.com`
  and add `user@example2.com` in the `Add Account` dialog.

    !!! note "Multiple accounts"
        Rainloop tracks accounts based on the login email. This means
        that in the example above, if the user logs in `user@example2.com`, the
        `user@example1.com` id will not show up.

## External domains

To add one or more external domains, add them in Rainloop's [admin panel](#admin-panel).

## Vacation Email

An out of office / vacation mail message can be setup using Sieve filters.

A vacation message can be set in `Settings` -> `Filters` -> `Add a filter`. Choose
`Vacation message` action.

<center>
<img src="/documentation/img/email-vacation-message-rainloop.png" class="shadow" width="600px">
</center>

## Forwarding all emails

To forward all emails to an external mail, setup a Sieve filter in
`Settings` -> `Filters` -> `Add a filter` -> `Forward to`

<center>
<img src="/documentation/img/forward-all-emails-rainloop.png" class="shadow" width="600px">
</center>

## Admin panel

The admin panel is located at `/?admin` and is disabled by default.

To enable it, open a [Web terminal](apps/#web-terminal)
and edit the file `/app/data/_data_/_default_/configs/application.ini`.
Set the value of `allow_admin_panel` to `On`. The default admin credentials
are:

    Username: admin
    Password: 12345


Restart the app for the changes to take effect.

!!! warning "Disable admin panel after use"
    We highly recommend disabling the admin panel after use.

