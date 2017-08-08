# Cloudron CLI

## What is Cloudron CLI

The Cloudron CLI can be used to remote control apps on the Cloudron
and script common actions from the PC/Mac. Some common use cases are:

* Viewing logs of an application
* 'shell' into the file system of an app using `cloudron exec` to make
   configuration changes.
* Building and installing application packages from source

## Installing Cloudron CLI

The Cloudron CLI is distributed via `npm`. The Cloudron CLI can be installed
on your PC using the following command:

```
sudo npm install -g cloudron
```

Node.js and npm can be installed by following the instructions
[here](https://nodejs.org/en/download/package-manager/). Cloudron CLI requires atleast
Node 4.x.

The Cloudron CLI is **NOT** intended to be installed on the Cloudron. The Cloudron
CLI is not actively tested on Windows but is known to work with varying success.
If you use Windows, we recommend using a Linux VM instead.

## Updating Cloudron CLI

The Cloudron CLI is distributed via `npm` and can be updated using the following command:

```
npm install -g cloudron@<version>
```

## Login using Cloudron CLI

Use the following command to connect Cloudron CLI to the Cloudron:

```
cloudron login my.<domain>
```

A successful login stores the authentication token in `~/.cloudron.json`.

## Installing apps from Cloudron Store using Cloudron CLI

The Cloudron CLI can install apps from the Cloudron Store using the Appstore Id. For example,
to install wordpress:

```
cloudron install --appstore-id org.wordpress.cloudronapp
```

You can figure the Appstore Id by navigating to the [Cloudron Store](https://cloudron.io/store/index.html)
and clicking on the app (see the URL).

## Listing apps on the Cloudron using Cloudron CLI

The Cloudron CLI can be used to list all the apps on your Cloudron using the following command:

```
cloudron list
```

The `Id` is the unique application instance id. `Location` is the subdomain in which the app is
installed. You can use either of these fields as the argument to `--app`.

## Viewing logs of an app using Cloudron CLI

To view the logs of an app, use the following command:

```
cloudron logs --app blog                                 # if the app is located in the 'blog' subdomain
cloudron logs --app 52aae895-5b7d-4625-8d4c-52980248ac21 # using the app id (for bare/naked domains)
```

You can pass `-f` to follow the logs. Note that not all apps log to stdout/stderr. For this
reason, you may need to look further in the file system for logs:

```
cloudron exec --app blog                   # shell into the app's file system
# tail -f /run/wordpress/wp-debug.log      # note that log file path and name is specific to the app
```

## Instrospecting the app's file system using Cloudron CLI

On the Cloudron, apps are containerized and run with a virtual file system. To navigate the
file system, use the following command:

```
cloudron exec --app blog          # if the app is located in the 'blog' subdomain
```

Apart from 3 special directories - `/app/data`, `/run` and `/tmp`, the file system of an app is
read-only. Changes made to `/run` and `/tmp` will be lost across restarts (they are also cleaned
up periodically).

If you need to fix a bug in the app source, you must build the app from source code. If you
submit a pull request, we can incorporate the fixes into the next version of app.

## Installing app from source code using Cloudron CLI

To install an app from source code:

```
git clone ssh://git@git.cloudron.io:6000/cloudron/wordpress-app.git
cd wordpress
cloudron build              # login using cloudron.io credentials
cloudron install
```

Note that, as expected, apps installed this way do not get updates via the Cloudron Store.
You can use this approach to make custom changes to apps.

