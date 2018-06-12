# <img src="/documentation/img/nodebb-logo.png" width="25px"> NodeBB App

## Installing plugins

NodeBB admin dashboard offers a UI to install plugins and themes in their dashboard.
However, some plugins/themes may need to be installed by hand. To do so, use the
[Web terminal](apps/#web-terminal):

```
    cd /app/code
    /usr/local/bin/gosu cloudron:cloudron npm install nodebb-theme-timuu
```

After installation, restart the app and activate the plugin in the NodeBB
dashboard.

