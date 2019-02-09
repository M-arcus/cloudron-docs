# Settings

## Cloudron Name

The Cloudron name can be changed by clicking on the edit button (pencil) in the `Settings` page.
The Cloudron name is used in the dashboard header, login page and email notifications.

<center>
<img src="/documentation/img/settings-cloudron-name.png" class="shadow" width="500px">
</center>

## Cloudron Avatar

The Cloudron avatar can be changed by clicking on the image in the `Settings` page.
The avatar is used in the dashboard header, login page and email notifications.

<center>
<img src="/documentation/img/settings-cloudron-avatar.png" class="shadow" width="500px">
</center>

## Timezone

The Cloudron server is configured to be in UTC. This is intentional and should not be changed.

Cloudron has an internal timezone setting that controls various cron jobs like backup, updates,
date display in emails etc. This timezone is detected based on the browser IP that was used to
activate the Cloudron. The auto-detected timezone can be displayed by running:

* `mysql -uroot -ppassword -e "SELECT * FROM box.settings WHERE name='time_zone'"`

```
mysql: [Warning] Using a password on the command line interface can be insecure.
+-----------+--------------+
| name      | value        |
+-----------+--------------+
| time_zone | Asia/Kolkata |
+-----------+--------------+
```

To change the timezone, run the following commands:

* `mysql -uroot -ppassword -e "UPDATE box.settings SET value='Asia/Kolkata' where name='time_zone'"`.
   The value is a timezone from the [tz database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)

* `systemctl restart box`

