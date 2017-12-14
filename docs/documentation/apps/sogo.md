# <img src="/img/sogo-logo.png" width="25px"> SOGo App

## Setting the timezone

Open a [Web terminal](/documentation/apps/#web-terminal) for SOGo:

* Edit `/app/data/sogo.conf` and set the `SOGoTimeZone` field to a value
  from https://github.com/inverse-inc/sogo/tree/master/SOPE/NGCards/TimeZones

* Restart SOGo

## UI Issues

SOGo behaves differently depending on how you access the app.
If you navigate to SOGo by clicking on the icon on your Cloudron
dashboard, parts of the SOGo UI do not work. To workaround this,
always use SOGo by opening a new browser tab and entering the
SOGo domain name directly.

