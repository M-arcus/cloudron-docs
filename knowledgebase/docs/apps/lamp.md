# <img src="/documentation/img/lamp-logo.png" width="25px"> Lamp App

## LAMP App on Cloudron

Running LAMP apps on the Cloudron is no different than what is available on
many hosting providers. You can upload your PHP code using SFTP or the
[Web terminal](/documentation/apps/#web-terminal) and then modify
the .htaccess and php.ini files as required. Most commonly used
[PHP extensions](#php-extensions) are pre-installed and you don't have to worry
about keeping them up-to-date.

The main advantage of using the Cloudron to host LAMP apps are:

*   DNS configuration, Let's Encrypt (SSL) certificate installation and renewal are automated.
*   Can use MySQL, LDAP and send email out of the box.
*   Don't have to worry about app and server backups, restore and updates since the Cloudron takes care of it.
*   Run multiple LAMP apps, isolated from one another, on same server easily.

## Installing LAMP app on Cloudron

The LAMP app can be installed from the [Cloudron App Store](https://cloudron.io/store/lamp.cloudronapp.html).

When installing the app, the SFTP port can be specified. SFTP can be disabled by unchecking the checkbox.

<center>
<img src="/documentation/img/lamp-install.png" class="shadow">
</center>

## Uploading LAMP app

The LAMP app can be upload using the Web terminal or SFTP.

### Web terminal

* Open a [web terminal](/documentation/apps/#web-terminal) for the app.

* Upload the app .zip or .tar.gz to `/tmp` using the upload button

* Use the terminal to extract the code to `/app/data/public`

```
# unzip /tmp/app.zip -d /app/data/public       # for zip files

# tar zxvf /tmp/app.tar.gz -C /app/data/public # for tarballs
```

### Using SFTP

The app can be uploaded using an SFTP client like [FileZilla](https://filezilla-project.org/).

*   Connect the SFTP client. The hostname is app's domain name. The default SFTP port is 2222.
    The username/password is the same as Cloudron credentials.

*   Upload it to the `public/` folder.

<center>
<img src="/documentation/img/lamp-filezilla.png" class="shadow">
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
credentials can be obtained from the [Web terminal](/documentation/apps/#web-terminal) by executing
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

## phpMyAdmin

[phpMyAdmin](https://www.phpmyadmin.net/) can be accessed at the
`/phpmyadmin` path of the app. Use the Cloudron credentials for
authentication.

<br/>
<center>
<img src="/documentation/img/lamp-phpmyadmin.png" class="shadow" height="300px">
</center>
<br/>

It is recommended to disable SFTP access after the LAMP app is setup.
This can be done by by unchecking the SFTP port in the app's configure
dialog.

<br/>
<center>
<img src="/documentation/img/lamp-disable-sftp.png" class="shadow" height="300px">
</center>
<br/>

## Cron support

For cron support, add a file named `/app/data/crontab` support.

The file can be edited using the [Web terminal](/documentation/apps/#web-terminal)
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
* php-ldap
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

### Step 1: Download ionCube

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
zend_extension=/app/data/ioncube/ioncube_loader_lin_7.0.so
```

The LAMP app has thread safety disabled, so we choose the extension without the `ts` extension.

### Step 4: Restart app

Lastly, restart the app for the extension to be enabled. You can do this using the `Restart` button
in the [web terminal](/documentation/apps/#web-terminal).

### Step 5: Verifying installation

Visit the LAMP app's default page to verify that the extension is enabled.

<center>
<img src="/blog/img/lamp-ioncube-installed.png" class="shadow">
</center>

## Running composer

`composer` is installed in `/usr/local/bin/composer` but is missing the the executable permissions.
This can be worked around by running it via the php cli. In addition, composer might complain about
running [as root](https://getcomposer.org/doc/faqs/how-to-install-untrusted-packages-safely.md). Run
composer as the `www-data` user to avoid the warning.

```
    sudo -u www-data php /usr/local/bin/composer install symfony/symfony-demo
```

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

## Custom HTTP headers

Custom HTTP headers can be set using `.htaccess`. apache `mod_headers`
is already enabled. See this [article](https://www.digitalocean.com/community/tutorials/how-to-configure-apache-content-caching-on-ubuntu-14-04#setting-expires-and-caching-headers-on-content) for more information.


