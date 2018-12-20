# Troubleshooting

This section will provide some general overview where to find log output and how to check relevant service states.

## Backup error

If you see a message like `task crashed with code null and signal SIGKILL`, this probably means the backup task
is running out of memory.

To rectify this, SSH into the server:

* Edit `/etc/systemd/system/box.service` and change the line that says `MemoryLimit=200M` to `MemoryLimit=400M`.
* `systemctl daemon-reload`
* `systemctl restart box`

## Logs

Logs for each component are located in `/home/yellowtent/platformdata/logs/`. Many of these logs are viewable
directly using the Cloudron dashboard in the `support`, `mail` or `system` view.

