# <img src="../img/redash-logo.png" width="25px"> Redash App

## SSH tunnel

If your data source cannot be reached over the internet, you can setup
a [SSH tunnel](https://discuss.redash.io/t/connect-to-mysql-postgres-over-ssh-tunnel/57).
[stunnel](https://www.stunnel.org/index.html) is another way to setup
a TCP tunnel.

## Admin access

The app is pre-setup with a admin account. To give admin access to other
users, login as admin and add users to the `admin` group.

Alternately, use the [Web terminal](/documentation/apps/#web-terminal) and
run the following command:

```
    bin/run ./manage.py users grant_admin <email>
```

## Login form

By default, the app allows user's to login via `Cloudron LDAP` and via
email. Once you have made one or more Cloudron user's as Redash admins,
the email login can be disabled. For this, use the [Web terminal](/documentation/apps/#web-terminal)
and add/edit a file `/app/data/env` and add the following line:

    export REDASH_PASSWORD_LOGIN_ENABLED=false

Restart the app for changes to take effect.

If you want to login as admin again at some point, set the above value
to `true`.

