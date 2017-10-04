# <img src="/img/wordpress-logo.png" width="25px"> Wordpress App

## Wordpress memory limit

The PHP memory limit is configured to match the app's [memory limit](https://cloudron.io/documentation/apps/#increasing-the-memory-limit-of-an-app). To increase Wordpress memory limit, change the app's memory limit.

Cloudron app is setup so that Wordpress automatically [sets](https://codex.wordpress.org/Editing_wp-config.php#Increasing_memory_allocated_to_PHP)
the `WP_MEMORY_LIMIT` option to match the PHP memory limit.

## Cron tasks

The app is configured to run Wordpress cron tasks every 5 minutes.

To run the cron tasks manually run the following command using the
[Web terminal](/documentation/apps/#web-terminal):

```
/app/code/wp --allow-root cron event run --due-now
```

Wordpress' built-in cron task schedule `wp-cron` is disabled since
it is [not effective](https://www.lucasrolff.com/wordpress/why-wp-cron-sucks/)
for low traffic websites.

