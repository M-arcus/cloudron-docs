# <img src="/documentation/img/sogo-logo.png" width="25px"> SOGo App

## Setting the timezone

Open a [Web terminal](apps/#web-terminal) for SOGo:

* Edit `/app/data/sogo.conf` and set the `SOGoTimeZone` field to a value
  from https://github.com/inverse-inc/sogo/tree/master/SOPE/NGCards/TimeZones

* Restart SOGo

## UI Issues

SOGo behaves differently depending on how you access the app.
If you navigate to SOGo by clicking on the icon on your Cloudron
dashboard, parts of the SOGo UI [do not work](https://sogo.nu/bugs/view.php?id=3900).

This issue manifests itself as:

* Email delete button not working
* Compose email popup not closing. Sometimes, it ends up closing the tab itself.
* The browser's web inspector console displays a DOMException with the message
`"Permission denied to access property \"$mailboxController\" on cross-origin object"`.

To workaround this, always use SOGo by opening a new browser tab and entering the
SOGo domain name directly.

