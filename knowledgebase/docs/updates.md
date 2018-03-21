# Updates

## How app updates work

Cloudron Apps are installed from the [Cloudron App Store](/appstore.html). Cloudron checks the Cloudron App Store
for updates periodically and updates them based on the update settings.

Cloudron always takes a backup of an app before performing an update. Should the backup creation fail,
the update will not be applied. If an update fails or the updated app misbehaves, the
Cloudron administrator can [rollback from a backup](/documentation/backups/#restoring-an-app-from-existing-backup).

Some app updates are not applied automatically. This can happen if a new version of the app has removed
some features that may be relied upon. In such a case, the update has to be manually approved. This is simply
a matter of clicking the `Update` button after reading the changelog.

<center>
<img src="../img/app_update.png" class="shadow" width="600px">
</center>

## Changing the app update interval

The app update schedule can be set in the `Ap Updates` section in the `Settings` menu:

<center>
<img src="../img/app-update-interval.png" class="shadow">
</center>

To disable app updates entirely, select `Update manually`. When automatic updates are disabled, the Cloudron
administrators will get an email notification as and when updates are available. Updates can then be
applied by clicking the update button.

## Rolling back an app update

To rollback an app update, simply [restore from a backup](/documentation/backups/#restoring-an-app-from-existing-backup).

## Cloudron Updates

Cloudron checks [cloudron.io](https://cloudron.io) periodically and applies any updates
automatically.

Cloudron always takes a complete backup of the platform data and all apps before applying
an update. Should the backup creation fail, the update will not be performed.

In the unlikely case an update fails, it can be [restored from the backup](/documentation/backups/#restoring-cloudron-from-a-backup).

## What happens when subscription is stopped

When you cancel the subscription, the Cloudron and installed apps stop receiving updates.
The server and the apps will continue to run forever. The subscription may be renewed at
any time (we may contact you if we notice that you regularly cancel and renew your subscription).

