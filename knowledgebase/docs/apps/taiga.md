# <img src="/documentation/img/taiga-logo.png" width="25px"> Taiga App

## Custom configuration

Taiga customizations are placed in two files:
* `conf.json` - This contains UI settings. On the Cloudron app, this file is
  located at `/app/data/conf.json`.

* `local.py` - This contains backend settings. On the Cloudron app, this file
  is located at `/app/data/customlocal.py`.

These customizations will persist across updates and restarts.

To edit these files use the [Web terminal](/documentation/apps#web-terminal).

## Importing a project

An existing project's json can be imported into Taiga as follows:

* Connect to taiga using the [Web terminal](/documentation/apps#web-terminal)
* Upload the project.json using the 'Upload to /tmp' button
* `su cloudron`
* `source /app/code/taiga/bin/activate`
* `cd /app/code/taiga-back`
* `python manage.py load_dump /tmp/project.json email@domain.tld`

