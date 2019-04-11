# <img src="/documentation/img/nextcloud-logo.png" width="25px"> Nextcloud App

## Installing Nextcloud client on Ubuntu

Nextcloud does not have it's own desktop client. The ownCloud client is compatible with Nextcloud.

The ownCloud client on Ubuntu is [outdated](https://bugs.launchpad.net/ubuntu/+source/owncloud-client/+bug/1718308).
The client will display an error:
```
Error downloading https://SERVERNAME/owncloud/remote.php/webdav/ - server replied: Forbidden (Unsupported client version.)".
```

To resolve the problem, install the ownCloud client by following the instructions [here](https://download.owncloud.com/repositories/desktop/download/):

```
sudo wget -nv https://download.owncloud.com/repositories/desktop/Ubuntu_16.04/Release.key -O Release.key
sudo apt-key add - < Release.key
sudo sh -c "echo 'deb http://download.owncloud.com/repositories/desktop/Ubuntu_16.04/ /' > /etc/apt/sources.list.d/owncloud.list"
sudo apt-get update
sudo apt-get install owncloud-client
```

!!! warning
    As of this writing, the ownCloud website links to the opensuse website for installing the owncloud client.
    The packages in the opensuse website do not work. See the [forum](https://central.owncloud.org/t/repository-bug-on-ubuntu-16-04/9546/7)
    and [GitHub issue](https://github.com/owncloud/client/issues/6034) for more information.

## Running occ tool

The `occ` tool can be used for Nextcloud [administrative tasks](https://docs.nextcloud.com/server/12/admin_manual/configuration_server/occ_command.html).

The occ command can be run using the [Web terminal](/documentation/apps#web-terminal). For example, to list the users:

```
    sudo -u www-data php -f /app/code/occ user:list
```

## Resetting admin password

To reset the admin password, run the following occ command using the [Web terminal](/documentation/apps#web-terminal):

```
    sudo -u www-data php -f /app/code/occ user:resetpassword admin
```

## Managing deleted files

When you delete a file in Nextcloud, it is not [immediately deleted](https://docs.nextcloud.com/server/12.0/user_manual/files/deleted_file_management.html) permanently. Instead, it is moved into the trash bin.
It is not permanently deleted until you manually delete it, or when the Deleted Files app deletes it to make room for
new files.

To configure, how items are permanently deleted, configure the [trashbin_retention_obligation](https://docs.nextcloud.com/server/12/admin_manual/configuration_server/config_sample_php_parameters.html#deleted-items-trash-bin) parameter.

The parameter can be edited using the [Web terminal](/documentation/apps#web-terminal) and editing the file
`/app/data/config/config.php`.

## Attaching external storage

Many VPS providers like Digital Ocean, Linode allow attaching external block storage to the server. Nextcloud has a feature
that allows mounting additional directories on the server as [external storage](https://docs.nextcloud.com/server/9/admin_manual/configuration_files/external_storage_configuration_gui.html).

Mounting an existing server directory as 'external storage' on Nextcloud is currently not supported.

If the intent is to simply increase the amount of storage available to Nextcloud (since you have run out of disk
space in the default data partition), there are two options:

* Configure Nextcloud to use an external object storage like Digital Ocean Spaces, AWS S3 etc
  * [DigitalOcean Spaces Guide](https://www.digitalocean.com/community/questions/is-it-possible-to-mount-do-spaces-as-external-storage-in-nextcloud-as-i-mount-aws-s3-storage)

* Configure Cloudron to store all of Nextcloud's data in the external block storage. To achieve this, follow the
  [guide](/documentation/storage/#moving-a-single-apps-data-directory-to-another-location) for
  moving a single app's data directory to another location.

Moving Nextcloud's directory entirely has the advantage that the iOS/Android app's Instant Upload feature uses
this new disk.

## Recan files

Nextcloud will not pick up files if they are added directly in the data directory of the user on the server.
To make it rescan, open a [Web terminal](/documentation/apps#web-terminal) and run the following command:

```
sudo -u www-data php -f /app/code/occ files:scan <username>
```

To rescan external storage, use the `--path` parameter.

```
sudo -u www-data php -f /app/code/occ files:scan <username> --path=/<username>/files/externaltest
```

## Fixing a broken install

The [Nextcloud App Store](https://apps.nextcloud.com/) has a wide variety of apps that can be installed on
top of Nextcloud. Nextcloud has no native sandboxing mechanism for plugins - if a plugin fails, it will bring
down the whole installation. Plugins might also break an installation after a Nextcloud upgrade. For this reason,
we encourage carefully reviewing apps before using them.

To fix a broken installation, open a [Web terminal](/documentation/apps#web-terminal) and repair the app. Then run the following
commands:

```
sudo -u www-data php -f /app/code/occ app:list            # this lists the apps
sudo -u www-data php -f /app/code/occ app:disable <app>   # use this to disable the faulty app
sudo -u www-data php /app/code/occ maintenance:mode --off
```

After running the commands, end the repair for the app to come up.

## Collabora Online Document Editor

Collabora Online is a powerful online office suite that supports all major document, spreadsheet and presentation
file formats, which you can integrate in your own infrastructure. Key features are collaborative editing and
excellent office file format support.

See the [Collabora App docs](app/collabora) on how to setup Nextcloud with Collabora Office.

<img src="/documentation/img/nextcloud-collabora-editor.png" class="shadow">

## Removing NextCloud users

To delete obsolete LDAP users and their data, see the [nextcloud docs](https://docs.nextcloud.com/server/stable/admin_manual/configuration_user/user_auth_ldap_cleanup.html?highlight=ldap).

