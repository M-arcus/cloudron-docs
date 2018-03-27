# <img src="../img/lychee-logo.png" width="25px"> Lychee App

## User management

Lychee is a single user app.

While lychee has a UI to change the password, there is no UI to reset the password.
If you forget the password, reset the password of the single user, use the [Web terminal](/documentation/apps/#web-terminal)
to delete the `lychee_settings` table. Lychee will regenerate it and ask you to enter a
new username and password.

```
    mysql --user=${MYSQL_USERNAME} --password=${MYSQL_PASSWORD} --host=${MYSQL_HOST} ${MYSQL_DATABASE} -e "DROP TABLE lychee_settings"
```

## Support image formats

Lychee [supports](https://github.com/electerious/Lychee/blob/master/docs/FAQ.md#which-image-file-formats-are-supported)
the following formats:

* `png`
* `gif`
* `jpeg`

Videos are not supported or [planned](https://github.com/electerious/Lychee/blob/master/docs/FAQ.md#can-i-upload-videos)).

## Using an existing folder structure

Lychee has it's own folder-structure and database. You have to
re-upload or re-import all your photos to use them.

