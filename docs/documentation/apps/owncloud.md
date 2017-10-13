# <img src="/img/owncloud-logo.png" width="25px"> ownCloud App

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

