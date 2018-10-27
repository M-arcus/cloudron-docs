# <img src="/documentation/img/monica-logo.png" width="25px"> Monica App

## Multiuser

By default, Monica is setup to be single user.

To enable user registration, open the [Web terminal](/documentation/apps#web-terminal) and add
the following variable in `/app/data/env`:
```
APP_DISABLE_SIGNUP=false
```

Refreshing the login page will now show a sign-up link in the login page.

## Mobile App

To enable the mobile app, open the [Web terminal](/documentation/apps#web-terminal) and run
the following command:

```
$ php artisan passport:client --password --name="MobileApp"
Password grant client created successfully.
Client ID: 8
Client Secret: Q1gM1DXaMUt8rdvU3MhC4dnxGrV2EdjnBfyj9Sjm
```

Now edit the file `/app/data/env` and search/edit the values:
```
MOBILE_CLIENT_ID=8
MOBILE_CLIENT_SECRET=Q1gM1DXaMUt8rdvU3MhC4dnxGrV2EdjnBfyj9Sjm
```

