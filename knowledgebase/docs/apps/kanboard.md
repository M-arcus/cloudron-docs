# <img src="/documentation/img/kanboard-logo.png" width="25px"> Kanboard App

## Installing plugins

Plugins are used to extend Kanboard. Kanboard has UI to install and uninstall plugins
via the UI at `/extensions/directory`.

See the [plugin docs](https://kanboard.org/#plugins) for a complete list.

Plugins can also be installed manually into `/app/data/plugins`.

* Open a [web terminal](/documentation/apps#web-terminal) for the app.

* Upload the app .zip or .tar.gz to `/tmp` using the upload button

* Use the terminal to extract the plugin to `/app/data/plugins`

```
# unzip /tmp/plugin.zip -d /app/data/plugins # for zip files
```

## Custom configuration

Custom plugin configuration can be stored in `/app/data/customconfig.php`. To edit
the file, use the [web terminal](/documentation/apps#web-terminal) for the app.

