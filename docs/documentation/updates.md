# Updates

## How app updates work

App updates are pushed via the Cloudron Store. The Cloudron checks for updates every midnight
and updates apps automatically.

Cloudron always takes a backup of an app before performing an update. Should the backup creation fail,
the update will not be performed. Should an update fail or misbehave after it has been applied, the
Cloudron administrator can rollback to the backup. Rolling back to a backup reverts not just the data
but also the code (so the app now runs the earlier working version).

Some app updates are not applied automatically. This can happen if a new version of the app has removed
some features that may be relied upon. In such a case, the update has to be manually approved. This is simply
a matter of clicking the `Update` button after reading the changelog.

<img src="/img/app_update.png" class="shadow">

## Changing the update interval

The update schedule can be set in the `Updates` section in the `Settings` menu:

<center>
<img src="/img/update-interval.png" class="shadow">
</center>

To disable updates entirely, select `Update manually`. When automatic updates are disabled, the Cloudron
administrators will get an email notification as and when updates are available. Updates can then be
applied by clicking the update button.

## Rolling back an app update

Apps can be restored to a previous version by clicking on the `Restore` button.

<center>
<img src="/img/app_restore_button.png" class="shadow">
</center>

Select the backup you want to restore to:

<center>
<img src="/img/app-select-backup.png" class="shadow">
</center>

Restoring will also revert the code to the version that was running when the backup was created. This is because the
current version of the app may not be able to handle old data.

## Cloudron Updates

Cloudron checks [cloudron.io](https://cloudron.io) for any update every night and applies
it automatically.

Cloudron always takes a complete backup of the platform data and all apps before applying
an update. Should the backup creation fail, the update will not be performed.

In the unlikely case an update fails, it can be [restored from the backup](documentation/backups/#restoring-cloudron-from-a-backup).

