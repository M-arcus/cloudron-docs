# Backup, Restore and Migrate

## How Cloudron backups work

## Configuring Cloudron backups

## How often does Cloudron take backups

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

## Import data into Cloudron apps

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

## Cloning a Cloudron app into another Cloudron

