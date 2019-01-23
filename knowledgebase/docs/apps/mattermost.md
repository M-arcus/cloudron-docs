# <img src="/documentation/img/mattermost-logo.png" width="25px"> Mattermost App

## Command Line Tool

The [Mattermost CLI tool](https://docs.mattermost.com/administration/command-line-tools.html) can be used
to administer user and team management tasks.

To use the CLI, open the [Web Terminal](/documentation/apps#web-terminal) and run the following command:

```
sudo -u cloudron /app/code/bin/mattermost --config=/app/data/config.json help
```

## Migration

In you want to migrate your existing non-Cloudron mattermost installation to Cloudron, do
the following:

* [Export data](https://docs.mattermost.com/administration/bulk-export.html#bulk-export-data) from the old
  installation as follow:

    ```
        sudo ./mattermost export bulk file.json --all-teams
    ```

* Install mattermost on Cloudron. Then use the [Web Terminal](/documentation/apps#web-terminal) to first upload
  the `file.json` above to the `/tmp` directory using the Upload button in the top of the Web terminal. Then,
  import it using the following command:

    ```
      sudo -u cloudron /app/code/bin/mattermost --config=/app/data/config.json import bulk --apply /tmp/file.json
    ```

