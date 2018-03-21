# <img src="/img/invoiceninja-logo.png" width="25px"> Invoice Ninja App

## Invoices

The app is pre-configured to send any invoices every 6 hours. To run the invoice
sending task manually, open a [Web terminal](/documentation/apps/#web-terminal) and run:

```
sudo -u www-data /usr/local/bin/php /app/code/artisan ninja:send-invoices
```

## Reminders

The app is pre-configured to send out reminders at 0800 UTC. This limitation
is because running the send-reminders cron more than once a day would
[cause problems](https://github.com/invoiceninja/invoiceninja/issues/1921#issuecomment-368806883)
(duplicate late fees, etc.).

To run the reminders task manually, open a [Web terminal](/documentation/apps/#web-terminal) and run:

```
sudo -u www-data /usr/local/bin/php /app/code/artisan ninja:send-reminders
```

## Cron logs

Cron logs are stored in `/app/data/storage/logs/cron.log`.


