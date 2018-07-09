# <img src="/documentation/img/etherpad-logo.png" width="25px"> Etherpad App

## Installing plugins

To install plugins or change the configuration, visit the admin
interface at `/admin`. Only Cloudron admins will have access to
this page.

A complete list of available plugins is available [here](https://static.etherpad.org/plugins.html).

## Admin user

When using Cloudron SSO, admins on the Cloudron automatically become admins
on etherpad.

When Cloudron SSO is disabled, an admin user can be created by adding users
to `settings.json`. Use the [Web terminal](apps/#web-terminal)
to edit `/app/data/settings.json` and add or edit the following section:

```
  "users": {
    "admin": {
      "password": "changeme1",
      "is_admin": true
    },
    "user": {
      "password": "changeme1",
      "is_admin": false
    }
  }
```

## Custom settings

Use a [Web terminal](apps/#web-terminal) and add any custom
settings to `/app/data/settings.json`.

!!! warning ""
    The app has to be restarted after editing `/app/data/settings.json`

### Make Documents Public

By default the app will always require login with a valid user.
To allow any visitor to create and edit documents, add the following to `/app/data/settings.json`:

```
  "requireAuthentication" : false,
```

## Customizing CSS

The CSS and Javascript can be customized by editing the files at `/app/data/custom/`.
See the [etherpad docs](http://etherpad.org/doc/v1.2.7/#index_custom_static_files) for
more information.

## API Access

The [Etherpad API](http://etherpad.org/doc/v1.3.0/#index_http_api) can be accessed by
obtaining the APIKEY. For this, open a [Web terminal](apps/#web-terminal)
and view the contents of the file `/app/data/APIKEY.txt`.

Example usage:

    curl https://etherpad.domain/api/1.2.7/listAllPads?apikey=c5513793f24a6fbba161e4497b26c734ff5b2701fad0f1211097ccb405ea65c7

