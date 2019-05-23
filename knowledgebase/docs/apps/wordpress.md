# <img src="/documentation/img/wordpress-logo.png" width="25px"> WordPress App

!!! note "Managed WordPress"
    This app is targeted at users who want a managed WordPress installation. The
    Cloudron team tracks upstream WordPress releases and publishes updates. The WordPress
    code is read-only and you have to extend WordPress using plugins. If you require full
    control over the installation including editing the WordPress code via SFTP, use the
    [WordPress (unmanaged) app](/documentation/apps/wordpress-unmanaged) instead.

## Admin page

The WordPress admin page is located `https://<my.example.com>/wp-login.php`.

## Using SFTP

The Managed WordPress app does not support editing files via SFTP. If you require SFTP access
to edit WordPress files, use the [WordPress (unmanaged) app](/documentation/apps/wordpress-unmanaged) instead.

## WordPress memory limit

The PHP memory limit is configured to match the app's [memory limit](https://cloudron.io/documentation/apps/#increasing-the-memory-limit-of-an-app). To increase WordPress memory limit, change the app's memory limit.

Cloudron app is setup so that WordPress automatically [sets](https://codex.wordpress.org/Editing_wp-config.php#Increasing_memory_allocated_to_PHP)
the `WP_MEMORY_LIMIT` option to match the PHP memory limit.

## Cron tasks

The app is configured to run WordPress cron tasks every 5 minutes.

To run the cron tasks manually run the following command using the
[Web terminal](/documentation/apps#web-terminal):

```
sudo -u www-data /app/code/wp cron event run --due-now
```

WordPress' built-in cron task schedule `wp-cron` is disabled since
it is [not effective](https://www.lucasrolff.com/wordpress/why-wp-cron-sucks/)
for low traffic websites.

## Plugins

Cloudron does not support plugins that modify the code. Code is read-only
and immutable. This property is essential for Cloudron to update apps correctly.

Use the [WordPress (unmanaged) app](/documentation/apps/wordpress-unmanaged) as an alternative
to install plugins that modify the code.

A list of plugins known to not work can be found [here](https://git.cloudron.io/cloudron/wordpress-app/issues?label_name%5B%5D=plugin).

## Performance

[GTmetrix](https://gtmetrix.com) is a great site for getting performance metrics on the
WordPress installation.

* To set the expires headers for all pages, the [WP Fastest Cache](https://wordpress.org/plugins/wp-fastest-cache/)
  plugin can be installed.

* For CDN caching, we recommend [WP Fastest Cache](https://wordpress.org/plugins/wp-fastest-cache/) or
[W3 Total Cache](https://wordpress.org/plugins/w3-total-cache/) for CDN based cache. Ryan Kite has a
[good tutorial](https://ryan-kite.com/how-to-create-a-cdn-for-wp-fastest-cache-with-aws-cloudfront/) on
how to setup AWS Cloudfront with WP Fastest Cache.

## Database access

Cloudron does not support PHPMyAdmin. It is, however, possible to access the database
using other methods:

* Open a [Web terminal](/documentation/apps#web-terminal) and press the 'MySQL' button to get console
  access. You can execute SQL commands directly.

* Use a plugin like [ARI Adminer](https://wordpress.org/plugins/ari-adminer/) for a GUI.

## WP CLI

[WP CLI](http://wp-cli.org/) is a command line interface to WordPress. To run commands
using the CLI tool, open a [Web terminal](/documentation/apps#web-terminal) and
execute commands WP CLI using `sudo -u www-data /app/code/wp`.

Additional php settings can be configured, when running the cli with `php -d key=value`:
```
sudo -u www-data php -d max_execution_time=100 /app/code/wp
```
In this case setting the maximum execution timeout to 100 seconds.

## PHP settings

You can add custom [PHP settings](http://php.net/manual/en/ini.core.php) in `/app/data/htaccess`
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

## Migrating existing site

See our [blog](/blog/2018-11-05-wordpress-migration.html) on how to migrate an existing
WordPress site to Cloudron.


