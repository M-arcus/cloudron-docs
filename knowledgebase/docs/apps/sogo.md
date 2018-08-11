# <img src="/documentation/img/sogo-logo.png" width="25px"> SOGo App

Like other email clients like rainloop or roundcube, SOGo only works with mailbox accounts on the Cloudron.
Login using the full email address including the domain as the username.

## Email

SOGo is setup out of the box as an email client for Cloudron for all mailboxes on the Cloudron.

By default the full name for sending out emails is currently prefilled with the email address.
Adjusting this to the real name, can be done by editing the IMAP account under `Preferences` -> `Mail`:

<center>
<img src="/documentation/img/sogo-email-identity-setup.png" class="shadow" width="100%">
</center>

### Sieve Scripts

SOGo UI only supports setting up a limited set of filtering rules. You can setup more advanced rules
using the Rainloop or Roundcube app.

## CalDAV

SOGo supports syncing using CalDAV:

Clicking on the 'ribbon' next to the calendar shows a popup menu.

<center>
<img src="/documentation/img/sogo-links-to-calendar.png" class="shadow" width="50%">
</center>

Clicking on `Links to this Calendar` will show the calendar settings for various clients.

<center>
<img src="/documentation/img/sogo-calendar-links.png" class="shadow" width="50%">
</center>

!!! note "Calendar URLs"
    CalDAV URL - https://sogo.domain.com/SOGo/dav/<username>/Calendar/personal/
    <br>
    Wedav ICS URL - https://sogo.domain.com/SOGo/dav/<username>/Calendar/personal.ics
    <br>
    WebDAV XML URL - https://sogo.domain.com/SOGo/dav/<username>/Calendar/personal.xml

## CardDAV

Clicking on the 'ribbon' next to the address book shows a popup menu.

<center>
<img src="/documentation/img/sogo-links-to-address-book.png" class="shadow" width="50%">
</center>

Clicking on `Links to this Address book` will show the address book settings for various clients.

<center>
<img src="/documentation/img/sogo-address-book-links.png" class="shadow" width="50%">
</center>

!!! note "Address book URLs"
    CardDAV URL - https://sogo.domain.com/SOGo/dav/<username>/Contacts/personal/

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

