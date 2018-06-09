# <img src="/documentation/img/monica-logo.png" width="25px"> Monica App

## Multiuser

Monica is setup by default to be single user. However one can enable user registration and thus makes the app mulit-user aware.

To enable user registration, open the webterminal of your app instance through the Cloudron dashboard and add the following
variable in `/app/data/env`:
```
APP_DISABLE_SIGNUP=false
```

Then restart the app with the restart button on the top of the webterminal.
Now you should see a sign-up link in the login page.
