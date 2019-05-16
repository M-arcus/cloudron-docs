# <img src="/documentation/img/wordpress-unmanaged-logo.png" width="25px"> WordPress (Unmanaged) App

!!! note "Unmanaged WordPress"
    This app is targeted at users who want to have complete control over their WordPress installation.
    The WordPress code can be accessed and edited via SFTP. WordPress' built-in updater has to be used
    to periodically check and install updates. If you prefer delegating the responsibility of applying
    updates to the Cloudron team, use the [WordPress app](/documentation/apps/wordpress)
    instead.

## Admin page

The WordPress admin page is located `https://<my.example.com>/wp-login.php`.

### Using SFTP

The app can be uploaded using an SFTP client like [FileZilla](https://filezilla-project.org/).

You can find the SFTP login details when clicking on the `i` icon in the app grid.

<center>
<img src="/documentation/img/lamp-filezilla.png" class="shadow">
</center>

## WordPress memory limit

The PHP memory limit is configured to match the app's [memory limit](https://cloudron.io/documentation/apps/#increasing-the-memory-limit-of-an-app). To increase WordPress memory limit, change the app's memory limit.

Cloudron app is setup so that WordPress automatically [sets](https://codex.wordpress.org/Editing_wp-config.php#Increasing_memory_allocated_to_PHP)
the `WP_MEMORY_LIMIT` option to match the PHP memory limit.

## Cron tasks

The app is configured to run WordPress cron tasks every 5 minutes.

To run the cron tasks manually run the following command using the
[Web terminal](/documentation/apps#web-terminal):

```
wp cron event run --due-now
```

WordPress' built-in cron task schedule `wp-cron` is disabled since
it is [not effective](https://www.lucasrolff.com/wordpress/why-wp-cron-sucks/)
for low traffic websites.

## Plugins

Unlike the [Managed WordPress app](/documentation/apps/wordpress), you can install
plugins that modify the code.

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
execute commands WP CLI using simply `wp`. It is pre-setup to run as the correct user already.

Additional php settings can be configured, when running the cli manually with `php -d key=value`:
```
sudo -u www-data php -d max_execution_time=100 /app/pkg/wp
```
In this case setting the maximum execution timeout to 100 seconds.

## PHP settings

You can add custom [PHP settings](http://php.net/manual/en/ini.core.php) in `/app/data/php.ini`

## Migrating existing site

See our [blog](/blog/2018-11-05-wordpress-migration.html) on how to migrate an existing
WordPress site to Cloudron.

