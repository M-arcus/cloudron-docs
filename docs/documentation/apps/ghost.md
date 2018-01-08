# <img src="/img/ghost-logo.png" width="25px"> Ghost App

## Structured data

Ghost outputs basic meta tags to allow rich snippets of your content to be recognised by popular social networks.
Currently there are 3 supported rich data protocols which are output in `{{ghost_head}}`:

- Schema.org - http://schema.org/docs/documents.html
- Open Graph - http://ogp.me/
- Twitter cards - https://dev.twitter.com/cards/overview

The Cloudron app enables output of [structured data](https://github.com/TryGhost/Ghost/blob/master/PRIVACY.md#structured-data)
by default.

## Migrating from Ghost 0.11

Ghost 1.0.0 is a major upgrade, with breaking changes and no automatic
migration path. To migrate the legacy Cloudron app (based on Ghost 0.11)
to the new Cloudron Ghost app follow the [official migration guide](https://docs.ghost.org/docs/migrating-to-ghost-1-0-0).

To summarize the steps:

* Export old blog's content as json from the `settings` > `labs page` in Ghost-Admin
* Download the images and custom themes. On the Cloudron, the content location is
  at `/app/data/content`. Use the [Web terminal's](/documentation/apps/#web-terminal)
  download button to download the contents as a `.tar.gz`.
* Install the new Cloudron Ghost app in a new subdomain
* Setup Ghost with a **different email address** than the one used in the old app, otherwise the user import will conflict.
* Import blog's json content from the `Labs` page
* Use the [Web terminal's](/documentation/apps/#web-terminal) upload
  button to upload the images and themes to `/tmp`. Then, extract the tarball to `/app/data/content`
```
rm -rf /app/data/content/*
tar zxvf /tmp/content.tar.gz -C /app/data/content/
```
* Use [Web terminal's](/documentation/apps/#web-terminal) restart button
  to restart the app

* Once everything looks fine, [uninstall](/documentation/apps/#uninstall-an-app) the old app
  and [move](/documentation/apps/#moving-an-app-to-another-subdomain) the new blog to the old
  location.


