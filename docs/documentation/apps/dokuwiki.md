# <img src="/img/dokuwiki-logo.png" width="25px"> Dokuwiki App

## Cloudron SSO integration

Any admin on Cloudron automatically becomes a dokuwiki admin.

## User management

When not using Cloudron authentication, first register a new user. Then
edit `/app/data/conf/users.auth.php` using the [Web terminal](/documentation/apps/#web-terminal):
and add the `admins` group to the new user.

You can also disable dokuwiki's user management by setting `useacl` to 0
in `/app/data/conf/local.php`.

## Disabling registration

You can disable registration by adding `$conf['disableactions']='register';`
to `/app/data/conf/local.php`.
