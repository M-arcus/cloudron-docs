# <img src="/documentation/img/kanboard-logo.png" width="25px"> Kanboard App

## Installing plugins

Plugins are used to extend Kanboard. See the [plugin docs](http://kanboard.net/plugins)
for a complete list.

Plugins are installed into `/app/data/plugins`.

* Open a [web terminal](apps/#web-terminal) for the app.

* Upload the app .zip or .tar.gz to `/tmp` using the upload button

* Use the terminal to extract the plugin to `/app/data/plugins`

```
# unzip /tmp/plugin.zip -d /app/data/plugins # for zip files
```

## Custom configuration

Custom plugin configuration can be stored in `/app/data/customconfig.php`. To edit
the file, use the [web terminal](apps/#web-terminal) for the app.

