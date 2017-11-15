# Cloudron CLI

## What is Cloudron CLI

The Cloudron CLI is a command line tool that uses the [REST API](/documentation/developer/api/)
to remote control apps on the Cloudron. The CLI tool is installed on Linux/Mac and can be used
for the following use cases:

* Viewing logs of an application
* 'shell' into the file system of an app using `cloudron exec` to make
   configuration changes.
* Building and installing application packages from source

## Installing Cloudron CLI

The Cloudron CLI is distributed via `npm`. The Cloudron CLI can be installed
on Linux/Mac using the following command:

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

!!! note "Self-signed certificates"
    When using Cloudron with self-signed certificates, use the `--allow-selfsigned` option.

## Installing apps from Cloudron Store using Cloudron CLI

The Cloudron CLI can install apps from the Cloudron Store using the Appstore Id. For example,
to install wordpress:

```
cloudron install --appstore-id org.wordpress.cloudronapp
```

The Appstore Id of an app can be found by navigating to the [Cloudron Store](https://cloudron.io/store/index.html)
and clicking on the app. The id can be deduced from the URL.

## Listing apps using Cloudron CLI

The Cloudron CLI can be used to list the installed apps using the following command:

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

Pass the `-f` to follow the logs. Note that not all apps log to stdout/stderr. For this
reason, you may need to look further in the file system for logs:

```
cloudron exec --app blog                   # shell into the app's file system
# tail -f /run/wordpress/wp-debug.log      # note that log file path and name is specific to the app
```

## Pushing a file to the app's file system using Cloudron CLI

To push a local file (i.e on the PC/Mac) to the app's file system, use the following command:

```
cloudron push --app blog blogdump.sql /tmp/blogdump.sql 
cloudron push --app blog blogdump.sql /tmp/               # same as above. trailing slash is required
```

To push a directory recursively to the app's file system, use the following command:

```
cloudron push --app blog files /tmp
```

## Pulling a file from the app's file system using Cloudron CLI

To pull a file from apps's file system to the PC/Mac, use the following command:

```
cloudron pull --app blog /app/code/wp-includes/load.php .  # pulls file to current dir
```

To pull a directory from the app's file system, use the following command:

```
cloudron pull --app blog /app/code/ .            # pulls content of code to current dir
cloudron pull --app blog /app/code/ code_backup  # pulls content of code to ./code_backup
```

## Browsing the app's file system using Cloudron CLI

On the Cloudron, apps are containerized and run with a virtual file system. To navigate the
file system, use the following command:

```
cloudron exec --app blog          # if the app is located in the 'blog' subdomain
```

Apart from 3 special directories - `/app/data`, `/run` and `/tmp`, the file system of an app is
read-only. Changes made to `/run` and `/tmp` will be lost across restarts (they are also cleaned
up periodically).

If you need to fix a bug in the app source, you must build the app from source code. Please
submit a merge/pull request, so we can incorporate the fixes into the next version of app.

## Executing a command using Cloudron CLI

The Cloudron CLI tool can be used to execute arbitrary commands in the context of app.

```
cloudron exec --app blog         # where 'blog' is the subdomain of the app
# ls                             # list files in the app's current dir
# mysql --user=${MYSQL_USERNAME} --password=${MYSQL_PASSWORD} --host=${MYSQL_HOST} ${MYSQL_DATABASE} # connect to app's mysql
```

Once exec'ed into the app, addons can be accessed as follows:

* LDAP - `ldapsearch -x -D cn=<username>,${LDAP_USERS_BASE_DN} -w <password> -h "${LDAP_SERVER}" -p "${LDAP_PORT}" -b  "${LDAP_USERS_BASE_DN}"`
* MongoDB - `mongo -u "${MONGODB_USERNAME}" -p "${MONGODB_PASSWORD}" ${MONGODB_HOST}:${MONGODB_PORT}/${MONGODB_DATABASE}`
* MySQL - `mysql --user=${MYSQL_USERNAME} --password=${MYSQL_PASSWORD} --host=${MYSQL_HOST} ${MYSQL_DATABASE}`
* PostgreSQL - `PGPASSWORD=${POSTGRESQL_PASSWORD} psql -h ${POSTGRESQL_HOST} -p ${POSTGRESQL_PORT} -U ${POSTGRESQL_USERNAME} -d ${POSTGRESQL_DATABASE}
`
* Redis - `redis-cli -h "${REDIS_HOST}" -p "${REDIS_PORT}" -a "${REDIS_PASSWORD}"`

## Installing an app from source code using Cloudron CLI

To install an app from source code:

```
git clone ssh://git@git.cloudron.io:6000/cloudron/wordpress-app.git
cd wordpress
cloudron build              # login using cloudron.io credentials
cloudron install
```

Note that, as expected, apps installed this way do not get updates via the Cloudron Store.
Use this approach to make custom changes to apps.

## Source code for apps

The source code of apps is located in our [GitLab](https://git.cloudron.io/cloudron). Look
for repos with the `-app` suffix.

