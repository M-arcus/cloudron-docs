# Troubleshooting

This section will provide some general overview where to find log output and how to check relevant service states.

## Services

Cloudron consists of a set of crucial service daemons, required for a functioning setup. If you encounter any issues, check the states of all services listed below and attempt to restart them if needed.

```
systemctl status <service>
systemctl restart <service>
```

| Service         | Description              | Recovery Info |
| --------------- | ------------------------ | ---------------: |
| box             | Cloudron service process | [Read More](/documentation/server/#box) |
| nginx           | Local reverse proxy      | |
| mysql           | Cloudron database engine | [Read More](/documentation/server/#mysql) |
| docker          | Container engine         | |
| unbound         | Internal DNS service     | [Read More](/documentation/server/#unbound) |
| cloudron-syslog | Daemon to collect logs   | |

Cloudron also runs apps and addons inside docker container. Those can be seen with `docker ps`.
Furthermore make sure to search within this documentation using the search field in the header. We are constantly adding more information here.

!!! tip "Premium Subscription"
    In case you have a Premium subscription and the Cloudron is still in some error state, run `/home/yellowtent/box/scripts/cloudron-support --enable-ssh` and send the resulting link to [support@cloudron.io](mailto:support@cloudron.io)

## Logs

Most logs are located individually for each component in `/home/yellowtent/platformdata/logs/`. They can be viewed directly via SSH in the terminal or through the logviewer inside the Cloudron dashboard. For apps it can be found [here](/documentation/apps/#log-viewer) otherwise in the `support`, `mail` or `system` view.

