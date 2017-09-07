# <img src="/img/ghost-logo.png" width="25px"> Ghost App

## Migrating from Ghost 0.11

Ghost 1.0.0 is a major upgrade, with breaking changes and no automatic
migration path. To migrate the legacy Cloudron app (based on Ghost 0.11)
to the new Cloudron Ghost app follow the [official migration guide](https://docs.ghost.org/docs/migrating-to-ghost-1-0-0).

To summarize the steps:

* Export old blog's content as json from the `settings` > `labs page` in Ghost-Admin
* Download the images and custom themes. On the Cloudron, the content location is
  at `/app/data/content`. Use the [Web terminal's](/documentation/apps/#modifying-files-of-an-app)
  download button to download the contents as a `.tar.gz`.
* Install the new Cloudron Ghost app in a new subdomain
* Import blog's json content from the `Labs` page
* Use the [Web terminal's](/documentation/apps/#modifying-files-of-an-app) upload
  button to upload the images and themes to `/tmp`. Then, extract the tarball to `/app/data/content`
```
rm -rf /app/data/content/*
tar zxvf /tmp/content.tar.gz -C /app/data/content/
```
* Use [Web terminal's](/documentation/apps/#modifying-files-of-an-app) restart button
  to restart the app

* Once everything looks fine, [uninstall](/documentation/apps/#uninstall-an-app) the old app
  and [move](/documentation/apps/#moving-an-app-to-another-subdomain) the new blog to the old
  location.

