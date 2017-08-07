# Updates

## How app updates work

All your apps automatically update as and when the application author releases an update. The Cloudron
will attempt to update around midnight of your timezone.

Some app updates are not automatic. This can happen if a new version of the app has removed some features
that you were relying on. In such a case, the update has to be manually approved. This is simply a matter
of clicking the `Update` button (the green star) after you read about the changes.

<img src="/img/app_update.png" class="shadow">

## Changing the update interval

## Disabling automatic updates

## Rolling back an app update

## Cloudron Upgrade

loudron platform itself updates in two ways: update or upgrade.

#### Update

An **update** is applied onto the running server instance. Such updates are performed
every night. You can also use the Cloudron UI to initiate an update immediately.

The Cloudron will always make a complete backup before attempting an update. In the unlikely
case an update fails, it can be [restored](/references/selfhosting.html#restore).

#### Upgrade

An **upgrade** requires a new OS image. This process involves creating a new server from scratch
with the latest code and restoring it from the last backup.

To upgrade follow these steps closely:

* Create a new backup - `cloudron machine backup create`

* List the latest backup - `cloudron machine backup list`

* Make the backup available for the new cloudron instance:

  * `S3` - When storing backup ins S3, make the latest box backup public - files starting with `box_` (from v0.94.0) or `backup_`. This can be done from the AWS S3 console as seen here:

    <img src="/img/aws_backup_public.png" class="shadow haze"><br/>

    Copy the new public URL of the latest backup for use as the `--restore-url` below.

    <img src="/img/aws_backup_link.png" class="shadow haze"><br/>

  * `File system` - When storing backups in `/var/backups`, you have to make the box and the app backups available to the new Cloudron instance's `/var/backups`. This can be achieved in a variety of ways depending on the situation: like scp'ing the backup files to the machine before installation, mounting the external backup hard drive into the new Cloudron's `/var/backup` OR downloading a copy of the backup using `cloudron machine backup download` and uploading them to the new machine. After doing so, pass `file:///var/backups/<path to box backup>` as the `--restore-url` below.

* Create a new Cloudron by following the [installing](/references/selfhosting.html#installing) section.
  When running the setup script, pass in the `--encryption-key` and `--restore-url` flags.
  The `--encryption-key` is the backup encryption key. It can be displayed with `cloudron machine info`

Similar to the initial installation, a Cloudron upgrade looks like:
```
$ ssh root@newserverip
> wget https://cloudron.io/cloudron-setup
> chmod +x cloudron-setup
> ./cloudron-setup --provider <digitalocean|ec2|generic|scaleway> --domain <example.com> --encryption-key <key> --restore-url <publicS3Url>
```

Note: When upgrading an old version of Cloudron (<= 0.94.0), pass the `--version 0.94.1` flag and then continue updating
from that.

 * Finally, once you see the newest version being displayed in your Cloudron webinterface, you can safely delete the old server instance.

