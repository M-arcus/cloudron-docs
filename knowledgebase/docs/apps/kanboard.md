# <img src="/documentation/img/kanboard-logo.png" width="25px"> Kanboard App

## Installing plugins

[Kanboard Plugins](https://kanboard.org/#plugins) are used to extend Kanboard. Kanboard has a UI to install and uninstall plugins
at `/app/data/plugins` directly.

Plugins can also be installed manually at `/app/data/plugins`.

* Open a [web terminal](/documentation/apps#web-terminal) for the app.

* Upload the app .zip or .tar.gz to `/tmp` using the upload button

* Use the terminal to extract the plugin to `/app/data/plugins`

```
# unzip /tmp/plugin.zip -d /app/data/plugins # for zip files
```

## Custom configuration

Custom plugin configuration can be stored in `/app/data/customconfig.php`. To edit
the file, use the [web terminal](/documentation/apps#web-terminal) for the app.

