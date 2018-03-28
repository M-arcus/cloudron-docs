# <img src="/documentation/img/mattermost-logo.png" width="25px"> Mattermost App

## Command Line Tool

For many administrative tasks like user and team management, Mattermost relies on its [command line tooling](https://docs.mattermost.com/administration/command-line-tools.html).
The main tool is the `platform` script, which is already present in the Mattermost Cloudron app package. However in order to correctly use it inside a Cloudron app instance, it must be run as the user `cloudron` and have the location of the configuration file specified. The executable is `/app/code/bin/mattermost`.

To see all available admin commands, open the [Web Terminal](/documentation/apps/#web-terminal) and run the following command:
```
sudo -u cloudron /app/code/bin/platform --config=/app/data/config.json help
```
