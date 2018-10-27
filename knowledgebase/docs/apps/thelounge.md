# <img src="/documentation/img/thelounge-logo.png" width="25px"> The Lounge App

## User management

When installed with Cloudron SSO enabled, add and remove users in the Cloudron
admin page.

When installed without Cloudron SSO enabled, new users must be added using
the Lounge CLI tools.

* Open a [Web terminal](/documentation/apps#web-terminal) for the app.
* Use the [lounge CLI](https://thelounge.github.io/docs/server/users.html) command
  to add a user:

```
root@3543a0255d97:/home/cloudron# lounge add girish
2017-10-28 05:21:59 [PROMPT] Enter password:
2017-10-28 05:22:02 [PROMPT] Save logs to disk? (yes)
2017-10-28 05:22:04 [INFO] User girish created.
2017-10-28 05:22:04 [INFO] User file located at /app/data/users/girish.json.
```

* To remove a user:

```
root@3543a0255d97:/home/cloudron# lounge remove girish
2017-10-28 05:22:21 [INFO] User girish removed.
```

!!! warning "Default admin user"
    With SSO disabled, the Cloudron app creates a default user named 'admin'
    for convenience. Be sure to change the password in the Lounge setting's
    page. If you do not intend to use this user, you can delete this user.


## Installing themes

[Lounge themes](https://thelounge.github.io/docs/plugins/themes.html) can be
installed using the lounge CLI tool.

* First, look for a theme at [npm](https://www.npmjs.com/search?q=keywords%3Athelounge-theme)
* Open a [Web terminal](/documentation/apps#web-terminal) for the app.
    * Run command `lounge install thelounge-theme-custom`
* Restart the app
* Select theme in options

