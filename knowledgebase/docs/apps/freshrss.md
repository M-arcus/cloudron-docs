# <img src="/documentation/img/freshrss-logo.png" width="25px"> FreshRSS

## Installing Extensions

To install extensions, simply extract them to `/app/data/extensions` and restart
the app.

The [web terminal](/documentation/apps#web-terminal) can be used to upload and extract extensions.

## Apps

To enable [mobile access](https://freshrss.github.io/FreshRSS/en/users/06_Mobile_access.html),

* In `Administration` -> `Authentication`, enable the option “Allow API access (required for mobile apps)”.
* Under the section `Profile`, fill-in the field `API password (e.g., for mobile apps)`.
  * Note that every user must define an API password.

### FeedMe

The [FeedMe Android app](https://play.google.com/store/apps/details?id=com.seazon.feedme) has support
for FreshRSS. When using this app, remember to use the hostname as `https://freshrss.example.com/api/greader.php`

