# Backup, Restore and Migrate

## How Cloudron backups work

The Cloudron creates backups once a day. Each app is backed up independently and these backup files
have the prefix `app_`. The platform data (users, groups, email, cloudron configuration) is backed
up independently in files with prefix `box_`.

By default, backups reside in `/var/backups`. Please note that having backups reside in the same
physical machine as the Cloudron server instance is dangerous and it must be changed to an external
storage location like S3 as soon as possible.

## Backing up to Amazon S3

Provide S3 backup credentials in the `Settings` page and leave the endpoint field empty.

Create a bucket in S3 (You have to have an account at [AWS](https://aws.amazon.com/)). The bucket can be setup to periodically delete old backups by
adding a lifecycle rule using the AWS console. S3 supports both permanent deletion
or moving objects to the cheaper Glacier storage class based on an age attribute.
With the current daily backup schedule a setting of two days should be sufficient
for most use-cases.

* For root credentials:
    * In AWS Console, under your name in the menu bar, click `Security Credentials`
    * Click on `Access Keys` and create a key pair.
* For IAM credentials:
* You can use the following policy to create IAM credentials:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "s3:*",
            "Resource": [
                "arn:aws:s3:::<your bucket name>",
                "arn:aws:s3:::<your bucket name>/*"
            ]
        }
    ]
}
```

The `Encryption key` is an arbitrary passphrase used to encrypt the backups. Keep the passphrase safe; it is
required to decrypt the backups when restoring the Cloudron.

### Backing up to Minio

[Minio](https://minio.io/) is a distributed object storage server, providing the same API as Amazon S3.
Since Cloudron supports S3, any API compatible solution should be supported as well, if this is not the case, let us know.

Minio can be setup, by following the [installation instructions](https://docs.minio.io/) on any server, which is reachable by the Cloudron.
Do not setup Minio on the same server as the Cloudron, this will inevitably result in data loss, if backups are stored on the same instance.

Once setup, minio will print the necessary information, like login credentials, region and endpoints in its logs.

```
$ ./minio server ./storage

Endpoint:  http://192.168.10.113:9000  http://127.0.0.1:9000
AccessKey: GFAWYNJEY7PUSLTHYHT6
SecretKey: /fEWk66E7GsPnzE1gohqKDovaytLcxhr0tNWnv3U
Region:    us-east-1
```

First create a new bucket for the backups, using the minio commandline tools or the webinterface. The bucket has to have **read and write** permissions.

The information to be copied to the Cloudron's backup settings form may look similar to:

<img src="/img/minio_backup_config.png" class="shadow"><br/>

The `Encryption key` is an arbitrary passphrase used to encrypt the backups. Keep the passphrase safe; it is
required to decrypt the backups when restoring the Cloudron.

## Configuring backup interval

Cloudron automatically creates a backup every night (in the timezone of your Cloudron).

## Migrate Cloudron to another server

Migrating apps from one Cloudron to another works by first creating a new backup of the app on the old Cloudron,
copying the backup tarball onto the new Cloudron's backup storage and then installing a new app, based on the backup on
the new Cloudron.

**Both Cloudrons have to use the same backup encryption key!**

The following step will migrate an app:
* Against the old Cloudron
```
cloudron backup create --app <subdomain/appid>
```
* Copy the new backup from the old Cloudron's backup storage to the new one. This can be done via the s3 webinterface
  or scp if the filesystem backend is used. The backup can be located by its backup ID, which can be seen with:
```
cloudron backup list --app <subdomain/appid>
```
* Make note of the app's appstore id and version from:
```
cloudron list
```
* Then login to the new Cloudron and install the new app based on the created backup:
```
cloudron login <new Cloudron domain>
cloudron install --appstore-id=<apps appstore id>@<specific version if required> --backup <backupId>
```
The backupId usually also includes a path prefix and looks like: `2017-07-17-121412-248/app_2d7f2a6a-4c17-43a6-80bc-0bd47a99727f_2017-07-17-121412-269_v4.1.1.tar.gz`

## Importing data into Cloudron apps

## Format of Cloudron backups

## Changing the Cloudron domain name

Cloudron's main domain can be changed without losing any data using the following steps.
If you are wary of the steps below, simple take a backup of cloudron (Settings -> Backup)
and restore the Cloudron with a different domain.

1. Edit `/home/yellowtent/configs/cloudron.conf`. It has a field called `fqdn`.
   Change this to the desired domain name.

2. If you use the `wildcard` or `manual` DNS backend, add a DNS `A` record manually
   for `*.example.com` and `example.com` to the server's IP. For, `route53`, `cloudflare`
   and other automated DNS backends, you can skip this step.

3. Edit `/home/yellowtent/platformdata/INFRA_VERSION`. It has a field called `version`.
   Bump the minor version of this field. For example, if the version is a.b.c, change it
   to a.b+1.c. It is important to _not_ change the major version (i.e 'a')

4. `systemctl restart box`

In 5 minutes or so, you should be able to reach `https://my.example.com`.

## Cloning a Cloudron app in same Cloudron

To clone an existing app to a new location within the same Cloudron, use the CLI tool's `clone` command.

To clone the app at location `myfiles` with it's latest backup into a new location `dolly`
use the following commands:

```
$ cloudron clone --app myfiles # create a backup

$ cloudron clone --app myfiles --backup latest # clone from the backup just created
Location: dolly
App cloned as id a426fdec-94e7-42c5-a1f4-ab1a5ac22427

 => Waiting to start installation
 => Registering subdomain
 => Downloading image
 => Download backup and restore addons .......
 => Creating container .
 => Setting up collectd profile
 => Waiting for DNS propagation ....
 => Wait for health check........

App is cloned

```

## Cloning a Cloudron app into another Cloudron

Cloudron app backups are essentially 'snapshots' of the app and are portable across Cloudrons.
To move an app from one Cloudron to another or to instantiate an app from an arbitrary backup
perform the following steps:

1. Make the app backup available in the destination Cloudron's backup directory.

2. Install the app using the following command:
```
cloudron install --backup <id> --appstore-id org.wordpress.cloudronapp@0.9.1
```

## Restore an app from backup

Apps can be restored to a previous backup by clicking on the `Restore` button.

<img src="/img/app_restore_button.png" class="shadow">

Note that restoring previous data might also restore the previous version of the software. For example, you might
be currently using Version 5 of the app. If you restore to a backup that was made with Version 3 of the app, then the restore
operation will install Version 3 of the app. This is because the latest version may not be able to handle old data.

## Restoring Cloudron from a backup

To restore a Cloudron from a specific backup:

* Select the backup - `cloudron machine backup list`

* Make the backup public

  * `S3` - Make the box backup publicly readable - files starting with `box_` (from v0.94.0) or `backup_`. This can be done from the AWS S3 console. Once the box has restored, you can make it private again.

  * `File system` - When storing backups in `/var/backups`, you have to make the box and the app backups available to the new Cloudron instance's `/var/backups`. This can be achieved in a variety of ways depending on the situation: like scp'ing the backup files to the new machine before Cloudron installation OR mounting an external backup hard drive into the new Cloudron's `/var/backup` OR downloading a copy of the backup using `cloudron machine backup download` and uploading them to the new machine. After doing so, pass `file:///var/backups/<path to box backup>` as the `--restore-url` below.

* Create a new Cloudron by following the [installing](/references/selfhosting.html#installing) section.
  When running the setup script, pass in the `version`, `encryption-key`, `domain` and `restore-url` flags.
  The `version` field is the version of the Cloudron that the backup corresponds to (it is embedded
  in the backup file name).

* Make the box backup private, once the upgrade is complete.

