# <img src="../img/owncloud-logo.png" width="25px"> ownCloud App

## Installing ownCloud client on Ubuntu

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

The `occ` tool can be used for ownCloud [administrative tasks](https://doc.owncloud.org/server/9.0/admin_manual/configuration_server/occ_command.html#using-the-occ-command).

The occ command can be run using the [Web terminal](/documentation/apps/#web-terminal). For example, to list the users:

```
    sudo -u www-data php -f /app/code/occ user:list
```

## Managing deleted files

When you delete a file in ownCloud, it is not [immediately deleted](https://doc.owncloud.org/server/9.0/user_manual/files/deleted_file_management.html) permanently. Instead, it is moved into the trash bin.
It is not permanently deleted until you manually delete it, or when the Deleted Files app deletes it to make room for
new files.

To configure, how items are permanently deleted, configure the [trashbin_retention_obligation](https://doc.owncloud.com/server/9.1/admin_manual/configuration_server/config_sample_php_parameters.html?highlight=trashbin_retention_obligation#deleted-items-trash-bin) parameter.

The parameter can be edited using the [Web terminal](/documentation/apps/#web-terminal) and editing the file
`/app/data/config/config.php`.

## Max upload size

The app is configured to allow maximum uploads of up to 5GB.

## Attaching external storage

Many VPS providers like Digital Ocean, Linode allow attaching external block storage to the server. ownCloud has a feature
that allows mounting additional directories on the server as [external storage](https://doc.owncloud.org/server/9.0/admin_manual/configuration_files/external_storage_configuration_gui.html).

Mounting an existing server directory as 'external storage' on ownCloud is currently not supported.

If the intent is to simply increase the amount of storage available to ownCLoud (since you have run out of disk
space in the default data partition), there are two options:

* Configure ownCloud to use an external object storage like Digital Ocean Spaces, AWS S3 etc.

* Configure Cloudron to store all of ownCloud's data in the external block storage. To achieve this, follow the
  [guide](/documentation/server/#moving-a-single-apps-data-directory-to-another-location) for
  moving a single app's data directory to another location.

Moving ownCloud's directory entirely has the advantage that the iOS/Android app's Instant Upload feature uses
this new disk.

