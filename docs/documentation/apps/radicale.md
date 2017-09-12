# <img src="/img/radicale-logo.png" width="25px"> Radicale App

## Migration to version 2.0

The migration process requires you to have both the legacy and the 2.0 app installed at the same time.
The data can be exported and migrated with the following steps:

1. Restart the legacy app. This will automatically export all data on startup.

2. Download `/tmp/export` from the legacy app, using the webterminal, to you computer as `export.tar.gz`.

3. Upload this file to the new 2.0 app.

4. Run the following command on the 2.0 app:

    tar -xzf /tmp/export.tar.gz -C /app/data

After those steps, apps contain the same data. After verifying this, you can
delete the legacy app and change the location of the 2.0 app.

!!! warning "The permissions file layout and rules have changed"
    Please read the section below to manually adjust those if you have edited them.
    They will not be migrated!


## Custom permissions (e.g. shared calendar)

Per default, each user can only access their own calendar and contacts. If you
want something more complicated you can change the permissions.

You can change the permissions by pushing a file using the Cloudron CLI tool at
`/app/data/rights`. The default content of that file is:

    [owner-write]
    user = .+
    collection = %(login)s(/.*)?
    permission = rw

    [read]
    user = .*
    collection =
    permission = r

You can extend the file using the syntax described in [the radicale documentation](http://radicale.org/rights/).
