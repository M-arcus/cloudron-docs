# LAMP App

<center>
<img src="/blog/img/lamp.png">
</center>

## LAMP App on Cloudron

Running LAMP apps on the Cloudron is no different than what is available on
many hosting providers. You can upload your PHP code using SFTP and then modify
the .htaccess and php.ini files as required. Most commonly used PHP extensions
are pre-installed and you don't have to worry about keeping them up-to-date.

The main advantage of using the Cloudron to host your LAMP apps are:
*   DNS configuration, Let's Encrypt (SSL) certificate installation and renewal are automated.
*   You can use MySQL, LDAP, OAuth and send email out of the box.
*   Don't have to worry about app and server backups, restore and updates since the Cloudron takes care of it.
*   Run multiple LAMP apps, isolated from one another, on same server easily.

## Installing LAMP app on Cloudron

First, install the LAMP app on your Cloudron from the [Cloudron App Store](https://cloudron.io/store/lamp.cloudronapp.html).

When installing the app, you can specify the port in which SFTP will be
available. You can disable SFTP by unchecking the checkbox, after you
are done with using SFTP.

<center>
<img src="/blog/img/lamp-install.png" class="shadow">
</center>

## Uploading LAMP app using SFTP

Once installed, you can upload the ImpressPages app using an SFTP client like
[FileZilla](https://filezilla-project.org/).

*   Download and extract [ImpressPages](https://www.impresspages.org/download)
*   Connect the SFTP client. The hostname is app's domain name. The SFTP port is 2222.
    The username/password is the same as your cloudron credentials.
*   Upload it to the `public/` folder.

<center>
<img src="/blog/img/lamp-filezilla.png" class="shadow">
</center>

## phpMyAdmin

You can now access the [phpMyAdmin](https://www.phpmyadmin.net/) at the
`/phpmyadmin` path of your app. Note that you have to authenticate using
your Cloudron credentials to access it.

<br/>
<center>
<img src="/blog/img/phpmyadmin.png" class="shadow" height="300px">
</center>
<br/>

We recommend that users lock down their LAMP app once they have done modifying it.
You can disable SFTP and phpMyAdmin access by unchecking the SFTP port in the
app's configure dialog.

<br/>
<center>
<img src="/blog/img/lamp-disable-sftp.png" class="shadow" height="300px">
</center>
<br/>

## Cron support

You can now add a file named `/app/data/crontab` for cron support. This is
how it looks in `FileZilla` (I added `0 * * * * php /app/code/update.php --feeds`
to the crontab):

<br/>
<center>
<img src="/blog/img/lamp-filezilla-crontab.png" class="shadow" height="300px">
</center>
<br/>

Note that you must restart the app after making any changes to the `crontab`
file. You can do this by pressing the 'Restart' button in the app's configure
dialog.

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

As an example, we will install [ionCube Loader](http://www.ioncube.com/), which is often required
to install commercial PHP apps.

#### Step 1: Download ionCube

Download and extract the `tar.gz` or `zip` Linux 64-bit ionCube packages to your PC/Mac from the
[ionCube website](https://www.ioncube.com/loaders.php) or use the [direct link](http://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz).

<br/>

#### Step 2: Upload using SFTP

Upload the extracted directory to the SFTP root directory (`/app/data`) of the Cloudron app
(i.e one level above `public/`).

<br/>

<center>
<img src="/blog/img/lamp-upload-ioncube.png" class="shadow">
</center>

<br/>

#### Step 3: Enable extension

In the top level directory of the Cloudron app (in `/app/data`), you will find a `php.ini`.

Add the following line to enable the extension (just add it before the many `;extension` lines):

```
zend_extension=/app/data/ioncube/ioncube_loader_lin_7.0.so
```

The LAMP app has thread safety disabled, so we choose the extension without the `ts` extension.

<br/>

#### Step 4: Restart app

Lastly, restart the app for the extension to be enabled. You can do this using the `Restart` button
in the app's configure dialog (the pencil icon in the app grid).

<br/>

<center>
<img src="/blog/img/lamp-restart.png" class="shadow">
</center>

## Verifying installation

Visit the LAMP app's default page to verify that the extension is enabled.

<br/>

<center>
<img src="/blog/img/lamp-ioncube-installed.png" class="shadow">
</center>

