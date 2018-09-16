# <img src="/documentation/img/wordpress-logo.png" width="25px"> Wordpress App

## Admin page

The Wordpress admin page is located `https://<my.domain.com>/wp-login.php`.

## Wordpress memory limit

The PHP memory limit is configured to match the app's [memory limit](https://cloudron.io/documentation/apps/#increasing-the-memory-limit-of-an-app). To increase Wordpress memory limit, change the app's memory limit.

Cloudron app is setup so that Wordpress automatically [sets](https://codex.wordpress.org/Editing_wp-config.php#Increasing_memory_allocated_to_PHP)
the `WP_MEMORY_LIMIT` option to match the PHP memory limit.

## Cron tasks

The app is configured to run Wordpress cron tasks every 5 minutes.

To run the cron tasks manually run the following command using the
[Web terminal](apps/#web-terminal):

```
/app/code/wp --allow-root cron event run --due-now
```

Wordpress' built-in cron task schedule `wp-cron` is disabled since
it is [not effective](https://www.lucasrolff.com/wordpress/why-wp-cron-sucks/)
for low traffic websites.

## Plugins

Cloudron does not support plugins that modify the code. Code is read-only
and immutable. This property is essential for Cloudron to update apps correctly.

A list of plugins known to not work can be found [here](https://git.cloudron.io/cloudron/wordpress-app/issues?label_name%5B%5D=plugin).

## Performance

[GTmetrix](https://gtmetrix.com) is a great site for getting performance metrics on the
Wordpress installation.

* To set the expires headers for all pages, the [WP Fastest Cache](https://wordpress.org/plugins/wp-fastest-cache/)
  plugin can be installed.

* For CDN caching, we recommend [WP Fastest Cache](https://wordpress.org/plugins/wp-fastest-cache/) or
[W3 Total Cache](https://wordpress.org/plugins/w3-total-cache/) for CDN based cache. Ryan Kite has a
[good tutorial](https://ryan-kite.com/how-to-create-a-cdn-for-wp-fastest-cache-with-aws-cloudfront/) on
how to setup AWS Cloudfront with WP Fastest Cache.

## Database access

Cloudron does not support FTP access or PHPMyAdmin. It is, however, possible to access the database
using other methods:

* Open a [Web terminal](apps/#web-terminal) and press the 'MySQL' button to get console
  access. You can execute SQL commands directly.

* Use a plugin like [ARI Adminer](https://wordpress.org/plugins/ari-adminer/) for a GUI.

## WP CLI

[WP CLI](http://wp-cli.org/) is a command line interface to Wordpress. To run commands
using the CLI tool, open a [Web terminal](apps/#web-terminal) and
execute commands WP CLI using `/app/code/wp --allow-root`.

