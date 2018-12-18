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
<img src="/documentation/img/app_update.png" class="shadow" width="600px">
</center>

## Changing the app update interval

The app update schedule can be set in the `Ap Updates` section in the `Settings` menu:

<center>
<img src="/documentation/img/app-update-interval.png" class="shadow">
</center>

To disable app updates entirely, select `Update manually`. When automatic updates are disabled, the Cloudron
administrators will get an email notification as and when updates are available. Updates can then be
applied by clicking the update button.

## Disabling automatic updates

The Cloudron teams tracks upstream app releases and pushes out tested updates for apps.
Apps updates are applied automatically based on the [update schedule](#changing-the-app-update-interval).
In addition, some app updates are [not applied automatically](#how-app-updates-work) when an app introduces
big new features and breaking changes.

Some apps like the [LAMP app](/store/lamp.cloudronapp.html) expect the user to upload application
code. This means that the Cloudron team cannot do comprehensive testing for an app update (for example,
maybe a change in the PHP version breaks the app). For such situations, automatic updates can be disabled
at a per-app level:

<center>
<img src="/documentation/img/app-disable-automatic-updates.png" class="shadow" width="500px">
</center>

## Rolling back an app update

To rollback an app update, simply [restore from a backup](/documentation/backups/#restoring-an-app-from-existing-backup).

## Cloudron Updates

Cloudron checks [cloudron.io](https://cloudron.io) periodically and applies any updates
automatically.

Cloudron always takes a complete backup of the platform data and all apps before applying
an update. Should the backup creation fail, the update will not be performed.

In the unlikely case an update fails, it can be [restored from the backup](backups/#restoring-cloudron-from-a-backup).

## What happens when subscription is stopped

When you cancel the subscription, the Cloudron and installed apps stop receiving updates.
The server and the apps will continue to run forever. The subscription may be renewed at
any time (we may contact you if we notice that you regularly cancel and renew your subscription).

