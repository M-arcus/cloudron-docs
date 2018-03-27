# <img src="../img/piwik-logo.png" width="25px"> Piwik App

## Installing plugins

Piwik plugins are available from the [Piwik Plugins Marketplace](https://plugins.piwik.org/)

* Open a [web terminal](/documentation/apps/#web-terminal) for the app.

* Upload the app .zip or .tar.gz to `/tmp` using the upload button

* Use the terminal to extract the plugin code to `/app/data/plugins`

```
# unzip /tmp/app.zip -d /app/data/plugins # for zip files

# tar zxvf /tmp/app.tar.gz -C /app/data/plugins # for tarballs
```

By default, when you install a plugin it is not activated. To activate a
plugin, go to the “Plugins” page in Administration and click “Activate”
next to the plugin name.

