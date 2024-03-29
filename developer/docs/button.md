# Cloudron Button

## Overview

The `Cloudron Button` allows anyone to install an application with
the click of a button on their Cloudron.

The button can be added to just about any website including the application's website
and README.md files in GitHub repositories.

## Prerequisites

The `Cloudron Button` is intended to work only for applications that have been
published on the Cloudron App Store. The [basic tutorial](/packaging/)
gives an overview of how to package and publish your application for the
Cloudron App Store.

## HTML Snippet

```
<img src="https://cloudron.io/img/button32.png" href="https://cloudron.io/button.html?app=<appid>">
```

_Note_: Replace `<appid>` with your application's id.

## Markdown Snippet

```
[![Install](https://cloudron.io/img/button32.png)](https://cloudron.io/button.html?app=<appid>)
```

_Note_: Replace `<appid>` with your application's id.


## Button Height

The button may be used in different heights - 32, 48 and 64 pixels.

[![Install](https://cloudron.io/img/button32.png)](https://cloudron.io/button.html?app=io.gogs.cloudronapp)

[![Install](https://cloudron.io/img/button48.png)](https://cloudron.io/button.html?app=io.gogs.cloudronapp)

[![Install](https://cloudron.io/img/button64.png)](https://cloudron.io/button.html?app=io.gogs.cloudronapp)

or as SVG

[![Install](https://cloudron.io/img/button.svg)](https://cloudron.io/button.html?app=io.gogs.cloudronapp)

_Note_: Clicking the buttons above will install [Gogs](http://gogs.io/).
