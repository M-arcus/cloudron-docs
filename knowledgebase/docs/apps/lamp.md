# <img src="/documentation/img/lamp-logo.png" width="25px"> Lamp App

## LAMP App on Cloudron

Running LAMP apps on the Cloudron is no different than what is available on
many hosting providers. You can upload your PHP code using SFTP or the
[Web terminal](/documentation/apps#web-terminal) and then modify
the .htaccess and php.ini files as required. Most commonly used
[PHP extensions](#php-extensions) are pre-installed and you don't have to worry
about keeping them up-to-date.

The main advantage of using the Cloudron to host LAMP apps are:

*   DNS configuration, Let's Encrypt (SSL) certificate installation and renewal are automated.
*   Can use MySQL, redis and send email out of the box.
*   Don't have to worry about app and server backups, restore and updates since the Cloudron takes care of it.
*   Run multiple LAMP apps, isolated from one another, on same server easily.

## Uploading LAMP app

The LAMP app can be upload using the Web terminal or SFTP.

### Using SFTP

The app can be uploaded using an SFTP client like [FileZilla](https://filezilla-project.org/).

You can find the SFTP login details when clicking on the `i` icon in the app grid.

<center>
<img src="/documentation/img/lamp-filezilla.png" class="shadow">
</center>

!!! note "SFTP Access"
    SFTP access for non-admin users can be granted using the [access control UI](/documentation/apps/#restricting-app-access-to-specific-users).

### Web terminal

* Open a [web terminal](/documentation/apps#web-terminal) for the app.

* Upload the app .zip or .tar.gz to `/tmp` using the upload button

* Use the terminal to extract the code to `/app/data/public`

```
# unzip /tmp/app.zip -d /app/data/public       # for zip files

# tar zxvf /tmp/app.tar.gz -C /app/data/public # for tarballs
```

## PHP settings

You can add custom [PHP settings](http://php.net/manual/en/ini.core.php) in `/app/data/public/.htaccess`
using the [Web terminal](/documentation/apps#web-terminal). Note that settings with a [mode](http://php.net/manual/en/configuration.changes.modes.php) of `PHP_INI_SYSTEM` cannot be set in htaccess files.

For example:

```
#example
php_value post_max_size 600M
php_value upload_max_filesize 600M
php_value memory_limit 128M
php_value max_execution_time 300
php_value max_input_time 300
php_value session.gc_maxlifetime 1200
```

## Apache settings

You can add custom [Apache settings](http://httpd.apache.org/docs/current/howto/htaccess.html) in `/app/data/public/.htaccess`
using the [Web terminal](/documentation/apps#web-terminal).

For example:
```
ServerSignature Off
```

## Custom HTTP headers

Custom HTTP headers can be set in `/app/data/public/.htaccess`. apache `mod_headers`
is already enabled. See this [article](https://www.digitalocean.com/community/tutorials/how-to-configure-apache-content-caching-on-ubuntu-14-04#setting-expires-and-caching-headers-on-content) for more information.

## PHP extensions

The LAMP app already includes most of the popular PHP extensions including the following:

* php-apcu
* php-cli
* php-curl
* php-fpm
* php-gd
* php-gmp
* php-imap
* php-intl
* php-json
* php-mbstring
* php-mcrypt
* php-mysql
* php-mysqlnd
* php-pgsql
* php-redis
* php-sqlite
* php-xml
* php-xmlrpc
* php-zip

You can check the complete list of pre-installed extensions by visiting the default index.php
of the app that prints out `phpInfo()`.

## Installing custom PHP extensions

The LAMP app supports installing custom PHP extensions. As an example, we will install [ionCube Loader](http://www.ioncube.com/),
which is often required to install commercial PHP apps.

!!! note "ionCube is already installed"
    The LAMP app has built-in support for ionCube. The installation steps for ionCube here are just an example.

### Step 1: Download extension

Download and extract the `tar.gz` or `zip` Linux 64-bit ionCube packages to your PC/Mac from the
[ionCube website](https://www.ioncube.com/loaders.php) or use the
[direct link](http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz).

### Step 2: Upload using SFTP

Upload the extracted directory to the SFTP root directory (`/app/data`) of the Cloudron app
(i.e one level above `public/`).

<center>
<img src="/documentation/img/lamp-upload-ioncube.png" class="shadow">
</center>

### Step 3: Enable extension

In the top level directory of the Cloudron app (in `/app/data`), you will find a `php.ini`.

Add the following line to enable the extension (just add it before the many `;extension` lines):

```
zend_extension=/app/data/ioncube/ioncube_loader_lin_7.2.so
```

The LAMP app has thread safety disabled, so we choose the extension without the `ts` extension.

### Step 4: Restart app

Lastly, restart the app for the extension to be enabled. You can do this using the `Restart` button
in the [web terminal](/documentation/apps#web-terminal).

### Step 5: Verifying installation

Visit the LAMP app's default page to verify that the extension is enabled.

<center>
<img src="/blog/img/lamp-ioncube-installed.png" class="shadow">
</center>

## Configuring MySQL

On the Cloudron, MySQL credentials are exposed as environment variables to the app.
These variables can change over time. This approach makes it possible for Cloudron
to transparently rotate the MySQL password periodically as a security measure and
also makes app easily migratable across Cloudrons.

The exposed environment variables are:
```
MYSQL_URL=            # the mysql url (only set when using a single database, see below)
MYSQL_USERNAME=       # username
MYSQL_PASSWORD=       # password
MYSQL_HOST=           # server IP/hostname
MYSQL_PORT=           # server port
MYSQL_DATABASE=       # database name (only set when using a single database, see below)
```

If the PHP app has a `config.php` that requires the MySQL credentials to be set, they can set as below:
```
'db' => array (
    'hostname' => getenv("MYSQL_HOST"),
    'username' => getenv("MYSQL_USERNAME"),
    'password' => getenv("MYSQL_PASSWORD"),
    'database' => getenv("MYSQL_DATABASE")
  ), // Database configuration
```

Some apps show a setup screen and will require the raw MySQL credentials. For such apps, the MySQL
credentials can be obtained from the [Web terminal](/documentation/apps#web-terminal) by executing
the following command:

```
# env | grep MYSQL_
```

<center>
<img src="/documentation/img/lamp-webterminal-mysql.png" class="shadow">
</center>

**IMPORTANT:** Once the installation is completed, be sure to switch the config file of the app to use
the environment variables using `getenv()` instead of the raw credentials. Otherwise, future updates
might break the app.

### Customizing MySQL

On Cloudron, the MySQL server is shared across all apps. Each app gets non-root credentials to
the database that helps isolate them from one another. This means one cannot configure mysql for
one app specifically.

However, many [MySQL variables](https://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html)
like `sql_mode` can be set per session by modifying your code as follows:

```
// connect to mysql and call the first query
mysql_query("SET SESSION SQL_MODE = 'TRADITIONAL'");
mysql_query("SET SESSION UNIQUE_CHECKS = false");
mysql_query("SET SESSION FOREIGN_KEY_CHECKS=0");
```

## phpMyAdmin

[phpMyAdmin](https://www.phpmyadmin.net/) can be accessed at the
`/phpmyadmin` path of the app. It uses basic auth through a htpasswd file
and is pre-setup with an admin account and a generated password.
The password can be found in the `phpmyadmin_login.txt` file,
alongside with details how to managed more users.

<br/>
<center>
<img src="/documentation/img/lamp-phpmyadmin.png" class="shadow" height="300px">
</center>
<br/>

If access does not work anymore, simply remove the file `.phpmyadminauth` and restart the app.
This will generate new phpMyAdmin credentials.

## Custom Startup Script

A custom startup script can be placed at `/app/data/run.sh`. For example,

```
#!/bin/bash

echo "This script is called before the app starts"

# create symlinks
rm -rf /app/data/var/cache
mkdir -p /run/cache
ln -sf /run/cache /app/data/var/cache
```

## Cron support

For cron support, add a file named `/app/data/crontab` support.

The file can be edited using the [Web terminal](/documentation/apps#web-terminal)
or `FileZilla`.

<br/>
<center>
<img src="/blog/img/lamp-filezilla-crontab.png" class="shadow" height="300px">
</center>
<br/>

The crontab contains a line like:

```
0 * * * * php /app/code/update.php --feeds
```

The app must be restarted after making any changes to the `crontab`
file. You can do this by pressing the 'Restart' button in the web terminal.

## Running composer

`composer` is installed in `/usr/bin/composer`. To install composer packages, first switch to the `www-data`
user (composer should not be run as root).

```
su - www-data
cd public           # this is where PHP code resides
composer require drush/drush
```

!!! note "Memory limit"
    The LAMP app runs with 256MB ram by default which is not enough for Composer. If you see a `Killed` error
    message after a composer run, increase the [memory limit](https://cloudron.io/documentation/apps/#increasing-the-memory-limit-of-an-app)
    of the app to 1GB.

## Reverse proxy setup

If you want to run for example a custom WordPress within this app, please note that the code will run behind a nginx proxy.
Apps like WordPress require some code in `wp-config.php` to handle such a setup:

```
/*
 http://cmanios.wordpress.com/2014/04/12/nginx-https-reverse-proxy-to-wordpress-with-apache-http-and-different-port/
 http://wordpress.org/support/topic/compatibility-with-wordpress-behind-a-reverse-proxy
 https://wordpress.org/support/topic/wp_home-and-wp_siteurl
 */
// If WordPress is behind reverse proxy which proxies https to http
if (!empty($_SERVER['HTTP_X_FORWARDED_FOR'])) {
    $_SERVER['HTTP_HOST'] = $_SERVER['HTTP_X_FORWARDED_HOST'];

    if ($_SERVER['HTTP_X_FORWARDED_PROTO'] == 'https')
        $_SERVER['HTTPS']='on';
}
```

## Health check

The LAMP app expects a 2xx response from the '/' path. If your app is completely protected,
then the healthcheck logic will mark your app as `not responding` instead of `running`.

You can work around this by adding the following check in the beginning of your php file:

```
if ($_SERVER["REMOTE_ADDR"] == '172.18.0.1') {
    echo "Cloudron healthcheck reponse";
    exit;
}
```
