# <img src="/documentation/img/tinytinyrss-logo.png" width="25px"> Tiny Tiny RSS

## Customizing configuration

Use the [Web terminal](/documentation//documentation/apps#web-terminal)
to place custom configuration under `/app/data/config.json`.

Please be careful when changing configuration since the Cloudron packaging
might depend on it.

## Installing Plugins

To install [plugins](https://git.tt-rss.org/fox/tt-rss/wiki/Plugins), simply extract
them to `/app/data/plugins` (system plugins) or `/app/data/plugins.local` (user plugins) and restart the app.

The [web terminal](/documentation/apps#web-terminal) can be used to upload
and extract plugins.

You can see list of plugins [here](https://git.tt-rss.org/git/tt-rss/wiki/Plugins)

## Installing themes

To install [themes](https://git.tt-rss.org/fox/tt-rss/wiki/Themes), simply extract them to `/app/data/themes` (system themes)
or `/app/data/themes.local` (user themes) and restart the app.

The [web terminal](/documentation/apps#web-terminal) can be used to upload
and extract themes.

Some suggested [themes](https://git.tt-rss.org/git/tt-rss/wiki/Themes):

* [Reeder](https://github.com/tschinz/tt-rss_reeder_theme)
* [Clean GReader](https://github.com/naeramarth7/clean-greader)
* [Feedly](https://github.com/levito/tt-rss-feedly-theme)

## Fever support

TinyTinyRSS supports Fever API using a plugin. There are many version of 
fever API floating around but [this version](https://github.com/wodev/tinytinyrss-fever-plugin#installation)
is known to work.

Instruction on how to setup the apps is in the [old forum page](https://tt-rss.org/oldforum/viewtopic.php?f=22&t=1981)

