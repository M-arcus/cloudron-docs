# REST API

## Overview

Cloudron provides a RESTful API to manage all aspects of the Cloudron like
adding users, configuring groups and installing apps.

If you are an app developer, the [Cloudron CLI tool](https://www.npmjs.com/package/cloudron) implements a workflow that allows
you to develop apps on your Cloudron. The CLI tool uses the REST API documented here.

## Using the Cloudron REST API

The Cloudron API is available at the `my` subdomain of your Cloudron. To access
the API, you need an access token that you can get from your `Account` page.

To create a token, click the `New Token` button:

<center>
<img src="../img/apitoken-new.png" class="shadow" width="500px">
</center>


Then, provide a token name:

<center>
<img src="../img/apitoken-name.png" class="shadow" width="500px">
</center>

The access token can be provided via the request query `?access_token=<token>`.

```
curl -H "Content-Type: application/json" https://my.cloudron/api/v1/users?access_token=$TOKEN
```

Alternately, the token can be provided via the Authorization header using `Bearer <token>`.

```
curl -H "Content-Type: application/json" -H "Authorization: Bearer <token>" https://my.cloudron/api/v1/users
```

When sending POST data be sure to set the `content-type` to `application/json`.

```
curl -X POST -H "Content-Type: application/json" -d '{ "enabled": false }' 'https://my.example.com/api/v1/mail/domain.com/mail_from_validation?access_token=token
```

### Requests

All requests must be made via `https` protocol to ensure that the connection is encrypted.

The general idea behind HTTP methods is:

* Use `GET` to retrieve resource information
* Use `DELETE` to destroy a resource
* Use `PUT` to update an existing resource
* Use `POST` to create a new resource

### Error

Error response objects have a `status` field indicating the HTTP error and a `message` field containing
a detailed description of the error.

### Pagination

APIs that list objects take a `page` query parameters to indicate the page number starting from index 1.
The `per_page` query parameter can be used to specify the number of items to be returned.

### Getting API Tokens

POST `/api/v1/developer/login` <scope>admin</scope>

Creates a token given user credentials.

Request:
```
{
    username: <string>,
    password: <string>
}
```

Set `username` to your username and `password` to your password. Currently, only Cloudron administrators can
create API tokens.

Response (200):
```
{
    token: <string>,        // Token used for accessing the API
    expiresAt: <date>       // ISO-8601 UTC date the token expires
}
```

Curl example:
```
curl -X POST -H "Content-Type: application/json" -d '{"username": "cloudron", "password":"cloudron"}' https://my.example.com/api/v1/developer/login
```

## Apps API

### Install app

POST `/api/v1/apps/install`  <scope>admin</scope>

Request:

```
{
    location: <string>,              // required: the subdomain on which to install the app
    domain: <string>,                // required: the domain on which to install the app
    appStoreId: <string>[@<semver>], // required: Cloudron App Store Id of the app. Alternately, provide a manifest
    manifest: <manifest>,            // manifest of the app to install. required if appStoreId is unset.
    portBindings: null || {          // mapping from application ports to public ports
    },
    accessRestriction: null || {     // required. list of users and groups who can access this application
        users: [ ],
        groups: [ ]
    },
    icon: <string>,                  // icon as base64 encoded string
    cert: <string>,                  // pem encoded TLS cert
    key: <string>,                   // pem encoded TLS key
    memoryLimit: <number>,           // memory constraint in bytes
    backupId: <string>,              // initialize the app from this backup
    backupFormat: <string>,          // the backup format (tgz or rsync) of the backupId
    xFrameOptions: <string>,         // set X-Frame-Options header, to control which websites can embed this app
    robotsTxt: <string>,             // robots.txt file content
    sso: <boolean>,                  // integrate with Cloudron user management
    enableBackup: <boolean>,         // enable automatic backups
    enableAutomaticUpdate: <boolean> // enable automatic updates
    alternateDomains: [{             // array of subdomain and domain that should redirect to this app
        subdomain: <string>
        domain: <string>
    }, ... ],
    cert: <string>,                  // PEM encoded certificate
    key: <string>,                   // PEM encoded certificate key
    debugMode: null || {             // launch app in debugging mode
        cmd: [ ],                    // array of strings with the command to run
        readonlyRootfs: <boolean>    // set to true if the app's file system must be read-only
    }
}
```

`appStoreId` is the [Cloudron App Store](https://cloudron.io/appstore.html) Id of this application. For example,
`io.gogs.cloudronapp` is the id of Gogs app. A specific version can be specified using the '@' suffix. For
apps that are not published on the Cloudron App Store, skip this field and provide a `manifest` instead. Apps
with an `appStoreId` will automatically be kept up-to-date as newer version of the app are published on the
store.

`manifest` is the [manifest](/manifest/) of the app to be installed. This
is only required if `appStoreId` is not provided. Apps with a manifest won't receive automatic updates.

`location` is the subdomain on which the app is installed. This can be empty if the app was installed on the naked domain.
If another app already exists in the same location, 409 is returned.

For apps that require login, `accessRestriction` is the *restricted* list of users and groups that can access this app.
If null, any user of this Cloudron can access this app. Note that the `accessRestriction` field only works if the app
is integrated with Cloudron Authentication.

`icon` is an application icon that is displayed in the web ui. If not provided, this is automatically downloaded
from the Cloudron App Store (or uses a fallback icon).

`cert` and `key` provide the TLS certificates. If the domain name of the app does not must match with the certificate
provided, a 400 will be returned.

`xFrameOptions` can hold one of the following values:
* `DENY` - to prevent embedding from any website
* `SAMEORIGIN` - allows embedding from the same domain as the app. This is the default.
* `ALLOW-FROM https://example.com/` - allows this app to be embedded from example.com

Read more about the options at [MDN](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options).

`memoryLimit` is the maximum memory this app can use (in bytes) including swap. If set to 0, the app uses the `memoryLimit` value set in the manifest. If set to -1, the app gets unlimited memory.

If `robotsTxt` if set, it will be returned as the response for `/robots.txt`. You can read about the
[Robots Exclustion Protocol](http://www.robotstxt.org/robotstxt.html) site.

If `backupId` is provided the app will be initialized with the data from the backup. The `backupFormat` specifies
the format of the backup.

The `sso` field can be set to `false` to disable Cloudron authentication. By default, single sign-on is
enabled. Note that this field works only if the app support Cloudron single sign-on.

Response (200):

```
{
    id: <string>,                    // a unique id for the app
}
```

On success, the installation progress can be tracked by polling [installationProgress](#get-app).

Curl example to install Gogs app at subdomain git-demo.cloudron.me:
```
curl -X POST -H "Content-Type: application/json" -d '{ "appStoreId": "io.gogs.cloudronapp", "location": "git", "accessRestriction": null }' -H 'Authorization: Bearer f34eb4d0d942c8f8b3c060f356f1bb6961bc07bfb3fa2b24188a240f3de975f5' https://my.example.com/api/v1/apps/install
```

Curl example to install specific version of Gogs app with SSH Port exposed at 6000:
```
curl -X  POST -H "Content-Type: application/json" -H "Authorization: Bearer 27ab70cfd10e615ec29f6d890947e2b72db47522754bfafcad6f9c0e6c9e84e9" -d '{ "appStoreId": "io.gogs.cloudronapp@0.12.6", "portBindings": { "SSH_PORT": 6000 }, "location": "git2", "accessRestriction": null }' https://my.example.com/api/v1/apps/install
```

To restrict access to Gogs app to the *developers* group:
```
curl -X  POST -H "Content-Type: application/json" -H "Authorization: Bearer 27ab70cfd10e615ec29f6d890947e2b72db47522754bfafcad6f9c0e6c9e84e9" -d '{ "appStoreId": "io.gogs.cloudronapp@0.12.6", "location": "git3", "accessRestriction": { "groups": [ "developers" ] } }' https://my.example.com/api/v1/apps/install
```

### Get app

GET `/api/v1/apps/:appId` <scope>admin</scope>

Gets information about the app with id `appId`.

Response (200):

```
{
    id: <string>,                    // a unique id for the app
    appStoreId: <string>,            // Cloudron App Store Id for updates
    manifest: <manifest>,            // current manifest of the app
    installationState: <enum>,       // See below
    installationProgress: <string>,  // friendly string indicating installation progress
    runState: <enum>,                // see below
    health: <enum>,                  // health of the application
    location: <string>,              // subdomain on which app is installed
    domain: <string>,                // domain on which app is installed
    fqdn: <string>,                  // the FQDN of this app
    accessRestriction: null || {     // list of users and groups who can access this application
        users: [ ],
        groups: [ ]
    },
    manifest: <manifest>,            // the application manifest
    portBindings: {                  // mapping from application ports to public ports
    },
    iconUrl: <url>,                  // a relative url providing the icon
    memoryLimit: <number>,           // memory constraint in bytes
    sso: <boolean>,                  // Enable single sign-on
    robotsTxt: <string>,             // robots.txt file content
    alternateDomains: [{             // array of subdomain and domain that should redirect to this app
        subdomain: <string>
        domain: <string>
    }, ... ],
    debugMode: null || {             // debug mode parameters
        cmd: [ ],                    // array of strings with the launch command
        readonlyRootfs: <boolean>    // set to true if the app's file system is read-only
    }
}
```

`id` is an unique id for this application.

`appStoreId` is the Cloudron App Store id of this application. Cloudron will use this id to look for updates to this application. This can be null if none was provided at installation time.

`manifest` is the [Cloudron Manifest](/manifest/) of the app.

`installationState` is one of the values below:

* `pending_install` - The app is being installed. Use the `installationProgress` field to track the progress.
* `pending_configure` - The app is being re-configured. For example, if the app was moved to a new location or the port bindings was changed.
* `pending_uinstall` - The app is being uninstalled.
* `pending_restore` - The app is being restored from a previous backup.
* `pending_update` - The app is being updated.
* `pending_force_update` - The app is being force-updated.
* `pending_backup` - The app is being backed up.
* `error` - There was an error executing one of the above pending commands.
* `installed` - The app is installed. Use the `runState` and `health` to determine if the app is running and healthy.

`installationProgress` is a string indicating the progress when the app's `installationState` is one of the `pending_*` states. It is
of the format `<percent>, <message>`.

`runState` is one of the values below:

* `pending_start` - The app is being started.
* `pending_stop` - The app is being stopped.
* `stopped` - The app was stopped.
* `running` - The app is running.

`health` is one of the values below:

* `healthy` - The app is responding to health checks and is healthy.
* `unhealthy` - The app is not responding to health checks.
* `error` - There was an error checking the health of the app.
* `dead` - The app is dead. Most likely it was stopped or being uninstalled.

`location` is the subdomain on which the app is installed. This can be empty if the app was installed on the naked domain. The app can be
accessed from `fqdn` i.e `https//<fqdn>`.

For apps that require login, `accessRestriction` is the *restricted* list of users and groups that can access this app.
If null, any user of this Cloudron can access this app. Note that the `accessRestriction` field only works if the app
is integrated with Cloudron Authentication.


`manifest` is the [application manifest](/manifest/).

For apps that support optional single sign-on, the `sso` field can be used to disable Cloudron authentication. By default, single sign-on is enabled.

### List apps

GET `/api/v1/apps` <scope>admin</scope>

Gets the list of installed apps.

Response (200):

```
{
    apps: [
        {
            id: <string>,                    // a unique id for the app
            appStoreId: <string>,            // Cloudron App Store Id for updates
            manifest: <manifest>,            // current manifest of the app
            installationState: <enum>,       // See below
            installationProgress: <string>,  // friendly string indicating installation progress
            runState: <enum>,                // see below
            health: <enum>,                  // health of the application
            location: <string>,              // subdomain on which app is installed
            domain: <string>,                // the domain on which to install the app
            fqdn: <string>,                  // the FQDN of this app
            accessRestriction: null || {     // list of users and groups who can access this application
                users: [ ],
                groups: [ ]
            },
            manifest: <manifest>,            // the application manifest
            portBindings: {                  // mapping for application ports to public ports
            },
            iconUrl: <url>,                  // a relative url providing the icon
            memoryLimit: <number>,           // memory constraint in bytes
            alternateDomains: [{             // array of subdomain and domain that should redirect to this app
                subdomain: <string>
                domain: <string>
            }, ... ],
        },
        ...
    ]
}
```

### Get icon

GET `/api/v1/apps/:appId/icon` <scope>admin</scope>

Gets the icon of the application with id `appId` as `image/png`.

The icon is used in the display at Cloudron admin UI.

### Backup app

POST `/api/v1/apps/:appId/backup` <scope>admin</scope>

Starts a backup of the application with id `appId`.

The backup progress can be tracked by polling the value of [installationProgress](#get-app).

### List app backups

GET `/api/v1/apps/:appId/backups` <scope>admin</scope>

Gets the backups of the application with id `appId`.

Use the [Backup](#download-backup) API to download the backup. Use the [Clone](#clone-app) API to create another instance of this app from a backup.

Response (200):

```
{
    backups: [
        {
            id: <string>,                   // a unique id for this backup
            creationTime: <date>,           // ISO-8601 date in UTC
            version: <semver>,              // the app version
            type: <string>,                 // 'app'
            dependsOn: [ <string>, ... ],   // always an empty array for app backups
            state: <string>                 // 'normal'
        },
        ...
    ]
}
```

### Restore app

POST `/api/v1/apps/:appId/restore` <scope>admin</scope>

Restores the app from a backup.

Request:

```
{
    backupId: null || <string>
}
```

`backupId` is an id from the [list app backups](#list-app-backups) API.

Note that app backups are tied to the app's version (see the `version` field of the backup). So, restoring
an app may result in reverting the app to a previous version.

Setting backupId to `null` has the same effect as reinstalling the application.

### Clone app

POST `/api/v1/apps/:appId/clone` <scope>admin</scope>

Clones the app from a backup.

Request:

```
{
    backupId: <string>,            // required. the cloned app will start with this data.
    location: <string>,            // required. the subdomain for the cloned app
    portBindings: null || {        // required. mapping from application ports to public ports
    }
}
```

`backupId` is an id from the [list app backups](#list-app-backups) API.

`location` is a subdomain for the cloned app and will result in a 409 in case of a conflict.

`portBindings` is a list of new tcp port mappings for the cloned app.

Response(201):

```
    {
        id: <string>                // app id of the new app
    }
```

The clone progress can be tracked by polling the value of [installationProgress](#get-app).
Be sure to use the `id` of the new app returned above and not the original app's id.

### Get logs

GET `/api/v1/apps/:appId/logs` <scope>admin</scope>

Get the logs of an application with id `appId`.

The `lines` query parameter can be used to specify the number of log lines to download.

The response has `Content-Type` set to 'application/x-logs' and `Content-Disposition` set to
`attachment; filename="log.txt`.

Response(200):

```
Line delimited JSON.

    {
        realtimeTimestamp: <number>,          // wallclock timestamp
        monotonicTimestamp: <number>,         // time passed since boot
        message: [ <byte>,... ],              // utf8 buffer
        source: <process name>                // source of this message
    }
```

Logs are aggregated from one or more `source`s. The application logs have the `source` set to `main`.
Other sources include `scheduler`.

### Get log stream

GET `/api/v1/apps/:appId/logstream` <scope>admin</scope>

Stream the logs of an application with id `appId` as a `text/event-stream`. See the [EventSource](https://developer.mozilla.org/en-US/docs/Web/API/EventSource)
interface documentation for details.

The `lines` query parameter can be used to specify the number of log lines to prefetch.

Response(200):

```
Line delimited JSON

    {
        realtimeTimestamp: <number>,          // wallclock timestamp
        monotonicTimestamp: <number>,         // time passed since boot
        message: [ <byte>,... ],              // utf8 buffer
        source: <process name>                // source of this message
    }
```
Logs are aggregated from one or more `source`s. The application logs have the `source` set to `main`.
Other sources include `scheduler`.

### Configure app

POST `/api/v1/apps/:appId/configure` <scope>admin</scope>

Re-configures an existing app with id `appId`.

Configuring an app preserves existing data. Cloudron apps are written in a way to support reconfiguring
any of the parameters listed below without loss of data.

Request:
```
    location: <string>,            // the subdomain on which to install the app
    domain: <string>,              // the domain on which to install the app
    portBindings: null || {        // mapping from application ports to public ports
    },
    accessRestriction: null || {   // list of users and groups who can access this application
        users: [ ],
        groups: [ ]
    },
    icon: <string>,                 // icon as base64 encoded string
    cert: <string>,                 // pem encoded TLS cert
    key: <string>,                  // pem encoded TLS key
    memoryLimit: <number>,          // memory constraint in bytes
    xFrameOptions: <string>,        // set X-Frame-Options header, to control which websites can embed this app
    robotsTxt: <string>,            // robots.txt file content
    debugMode: null || {            // debug mode parameters
        cmd: [ ],                   // array of strings with the launch command
        readonlyRootfs: <boolean>   // set to true if the app's file system is read-only
    },
    alternateDomains: [             // setup redirection from these domains to the app
        {
            subdomain: <string>,
            domain: <string>        // must be a valid Cloudron domain
        },
        ...
    ],
    enableBackup: <boolean>,         // enable automatic backups
    enableAutomaticUpdate: <boolean> // enable automatic updates
    mailboxName: <string>,          // name of the mailbox assigned to this application
```

All values are optional. See [Install app](#install-app) API for field descriptions.

### Update app

POST `/api/v1/apps/:appId/update` <scope>admin</scope>

Updates an app with id `appId`.

Updating an app updrades (or downgrades) the app preserving existing data. To be safe, the update process
makes a backup of existing app data first before updating the app. This allow you to
[restore the app](#restore-app) should the upgrade fail.

Only apps that are installed, running and responding to health checks can generate a consistent back up.
For this reason, it is not possible to update apps that are in any other state. To override this, use
the `force` parameter described below.

Request:

```
{
    appStoreId: <string>[@<semver>], // the new version of the app
    manifest: <manifest>,            // the manifest of the app
    icon: <string>,                  // optional
    force: <boolean>                 // optional. default: false
}
```

`appStoreId` is the id of the app to install from the Cloudron App Store. The API does not verify that
the version provided here is greater than the existing app version allowing you to downgrade apps.
Downgrading should be used with extreme care because the older version of the app may not understand
the format of existing data (for example, new db schema may not be understod by the older version).

`manifest` provides information of the new app version that the app needs to be updated to. This is
only required if appStoreId was not provided at installation time.

`icon` specifies any new icon as a base64 encoded string for the updated version of the app.

The Cloudron will only update apps that are installed, running and responding to health checks. Before
each update, the app is backed up so that it may be restored easily in case of a bad update.

`force` can be used to force an update even if the app is in a state which prevents an update. This is
useful during app development, where you can force a crashed app to update to the latest code. The
`force` flag has the following implications tailored for app development:

* App is not backed up before an update
* The manifest `appStoreId` does not need to match the installed app's `appStoreId`
* An update is attempted even if the app is currently in an inconsistent state

!!! warning "New port bindings"
    If the new version of the app requires new ports to be allocated for the app, then any such new port will be disabled after the update and needs to be manually enabled by reconfiguring the app.

The update progress can be tracked by polling the value of [installationProgress](#get-app).

Curl example to update Gogs to a new version 0.13.0:
```
curl -X POST -d '{ "appStoreId": "io.gogs.cloudronapp@0.13.0" }' -H 'Content-Type: application/json' -H 'Authorization: Bearer 256e4c6c6f783dbff95ae233c63a36e297ef70a3528171b891a399f895a8e0e0' https://my.example.com/api/v1/apps/aaa8ad53-301b-4a77-9551-5df261686166/update
```

### Exec

GET `/api/v1/apps/:appId/exec` <scope>admin</scope>

Executes an arbitrary command in the context of the app.

Query Parameters:
* `cmd`: JSON encoded string array of the command to execute. default: '/bin/bash'
* `rows`: optional. the tty window row size
* `columns`: optional. the tty window column size
* `tty`: set to true if a tty should be allocated

In order to provide separate streams for **stdout** and **stderr**, the http connection
is upgraded to **tcp** using the following headers:
```
Upgrade: tcp
Connection: Upgrade
```

Once upgraded, the connection provides a full-duplex tcp connection. Clients can write **stdin**
to the connection. If a `tty` was allocated, then the server provides stdout and stderr as a
single stream. If no `tty` was allocated, then the server writes data in the following format:

```
<stream type> <size> <payload>
```

See the [Docker docs](https://docs.docker.com/engine/reference/api/docker_remote_api_v1.19/#attach-to-a-container)
for details.

Curl example to execute 'ls' command:
```
curl -H 'Upgrade: tcp' -H 'Connection: Upgrade' -H 'Authorization: Bearer eba011a45eb056c7497820c408d1170e94ac7ed0fb10cef798fcdaacbcbcd2ee' 'https://my.example.com/api/v1/apps/41dfe1f1-edb3-4011-9ba3-889d0b24a177/exec?cmd=%5B%22ls%22%5D&tty=true'
```

### Exec Websocket

WS `/api/v1/apps/:appId/execws` <scope>admin</scope>

This is the websocket version of the [exec](#exec) API.

### Start app

POST `/api/v1/apps/:appId/start` <scope>admin</scope>

Starts an app.

If the app cannot be started, the response code is 409. This can happen if the
app is in a state where it cannot started (for example, it is still installing).

### Stop app

POST `/api/v1/apps/:appId/stop` <scope>admin</scope>

Stops an app.

If the app cannot be stopped, the response code is 409. This can happen if the
app is in a state where it cannot stopped (for example, it is installing).

When an app is stopped, the app's location will show an error page indicating
that the app is not running.

### Upload file

POST `/api/v1/apps/:appId/upload` <scope>admin</scope>

Uploads a file to the file system of the app.

The `file` query parameter must be set to the destination path.

The file contents must be uploaded as a multipart request with a part named `file`.

Example:
```
curl -X POST -F "file=@sample.txt" 'https://my.forwardbias.in/api/v1/apps/baa2b3c1-e8bb-4db6-86e0-e09b02ca587d/upload?access_token=d556eb6892f38c3acbfaf5d75577b405bd00d8fa9db5f3cecd241a20df8c1bfa&file=/tmp/sample.txt'
```

### Download file

GET `/api/v1/apps/:appId/download` <scope>admin</scope>

Downloads a file from the file system of the app.

The `file` query parameter must be set to the path of the file.

If the file exists, the response will contain the contents of the file with
`Content-Disposition: attachment`.

### Uninstall app

POST `/api/v1/apps/:appId/uninstall` <scope>admin</scope>

Uninstalls an app.

The existing backups of the app are still preserved (as per the backup configuration) and the
backup can be used to restore the app to the same state later.

## Backups

### Create backup

POST  `/api/v1/backups` <scope>admin</scope>

Schedules a complete backup of the Cloudron.

Use the [Progress API](#get-progress) to track the progress of the backup.

### List backups

GET `/api/v1/backups` <scope>admin</scope>

Lists the existing `box` backups.

The Cloudron has two types of backups:

* `app` backups - Each app is backed up individually. This approach allows one to restore each app
independently of other apps. Use the [app backup API](#list-app-backups), if
you want to list the backups of a specific app.
* `box` backups - The Cloudron backs up certificates, user information, settings separately. This
backup contains a (virtual) link to all the app backups .

Response (200):
```
{
    backups: [
        {
            id: <string>,                   // a unique id for this backup
            creationTime: <date>,           // ISO-8601 date in UTC
            version: <semver>,              // the Cloudron version when this backup was created
            type: <string>,                 // `box`
            dependsOn: [ <string>, ... ],   // list of app backups that are part of this box backup
            state: <string>                 // 'normal'
        },
        ...
    ]
}
```

## Cloudron

### DNS Setup

POST `/api/v1/cloudron/dns_setup`

Sets up the initial domain for the Cloudron. Unlike other API calls,
this request is posted to the IP address of the Cloudron.

Request:
```
{
    domain: <string>,      // required: a domain under which apps will be installed
    adminFqdn: <fqdn>,     // must always be 'my.' + domain,
    zoneName: <string>,    // optional: the DNS zone name. defaults to the domain name itself
    provider: <string>     // required: 'route53', 'gcdns', 'digitalocean', 'cloudflare', 'noop' or 'manual'
    config: <object>,      // optional: provider specific DNS settings
    tlsConfig: {
        provider: <string> // 'letsencrypt-prod', 'letsencrypt-staging' or 'fallback'
    }
}
```

Example:
```
curl -k -X POST -H "Content-Type: application/json" -d '{"domain":"smartserver.space","adminFqdn":"my.smartserver.space","provider":"noop","config":{}, "tlsConfig":{"provider":"fallback"}}' https://159.65.67.243/api/v1/cloudron/dns_setup
```

### Activate the Cloudron

POST `/api/v1/cloudron/activate`

Activates the Cloudron with an admin username and password.

Request:
```
{
    username: <string>,     // the admin username
    password: <string>,     // the admin password
    email: <email>          // the admin email
}
```

Response (201):
```
{
  "token": "771ee724a66aa557f95af06b4e6c27992f9230f6b1d65d5fbaa34cae9318d453",
  "expires": 1490224113353
}

```

The `token` parameter can be used to make further API calls.

Curl example to activate the cloudron:

```
curl -X POST -H "Content-Type: application/json" -d '{"username": "girish", "password":"MySecret123#", "email": "girish@cloudron.io" }' https://my.cloudron.info/api/v1/cloudron/activate
```

### Check for updates

POST `/api/v1/check_for_updates` <scope>admin</scope>

Checks for any available updates for the Cloudron and the installed apps.

Response (200):
```
{
    box: null|<object>,            // object containing information about update
    apps: {                        // update info (if any) for each app
        <appid>: <object>,
        ...
    }
}
```

### Update the Cloudron

POST `/api/v1/cloudron/update` <scope>admin</scope>

Updates the Cloudron to the latest version.

If no new version is available, the response code will be 422.

Some actions and events on the Cloudron like backups, app installs may block the Cloudron from updating.
In such a case, the response code will be 409.

If the update request was accepted, the response code will be 202. Use the [Progress API](#get-progress)
to track the progress of the update.

### Reboot the Cloudron

POST `/api/v1/cloudron/reboot` <scope>admin</scope>

Reboots the Cloudron.

### Get progress

GET `/api/v1/cloudron/progress` <scope>public</scope>

Gets information about an in-progress Cloudron update or backup.

`update` or `backup` is `null` when there is no such activity in progress.

Response (200):

```
{
    update: null || { percent: <number>, message: <string> },
    backup: null || { percent: <number>, message: <string> }
}
```

### Get status

GET `/api/v1/cloudron/status` <scope>public</scope>

Gets information about the Cloudron state and how it got provisioned.

```
Response (200):
{
    activated: <boolean>,
    version: <semver>,
    apiServerOrigin: <url>,    // Always https://api.cloudron.io
    provider: <string>,
    cloudronName: <string>
}
```

### Get avatar

GET `/api/v1/cloudron/avatar` <scope>public</scope>

Returns the Cloudron avatar image as `Content-Type: image/png`.

```
Response (200):

Content-Type: image/png
```

### Get configuration

GET `/api/v1/cloudron/config` <scope>admin</scope>

Gets information on how the Cloudron is configured. This is similar to the [Status API](#get-status)
except this contains some sensitive information and is not public.

```
Response (200):
{
    apiServerOrigin: <string>,        // Always https://api.cloudron.io
    webServerOrigin: <string>,        // Always https://cloudron.io
    fqdn: <fqdn>,                     // The FQDN
    ip: <ip>,                         // The public IP
    version: <semver>,                // Current version
    update: {
        box: <semver>,                // Set to the next available Cloudron version
        apps: {
            <appid>: <semver>.        // Set to next available app version
            ...
        }
    },
    progress: {                       // See progress API
    },
    isCustomDomain: <boolean>,        // false if the cloudron is on a .cloudron.me subdomain. true otherwise
    developerMode: <boolean>,
    region: <string>,                 // the geo-region of this Cloudron
    size: <string>,                   // the size of this Cloudron
    billing: <boolean>,               // true if the user has setup billing
    memory: <string>,                 // the physical memory
    provider: <string>,
    cloudronName: <string>            // the name of this cloudron
}
```

### Get disks

GET `/api/v1/cloudron/disks` <scope>admin</scope>

Gets information on the disks being used on the Cloudron server.

```
Response (200):
{
    boxDataDisk: <string>,            // Disk used for storing box data
    platformDataDisk: <string>,       // Disk used for addon databases and email
    appsDataDisk: <string>            // Disk used for apps' local storage
}
```

### Get logs

GET `/api/v1/cloudron/logs` <scope>admin</scope>

Get the system logs.

The `lines` query parameter can be used to specify the number of log lines to download.

The `units` query parameters can be set to `box` or `mail` to get logs of specific units.

The response has `Content-Type` set to 'application/x-logs' and `Content-Disposition` set to
`attachment; filename="log.txt`.

Response(200):

```
Line delimited JSON.

    {
        realtimeTimestamp: <number>,          // wallclock timestamp
        monotonicTimestamp: <number>,         // time passed since boot
        message: [ <byte>,... ],              // utf8 buffer
        source: <process name>                // source of this message
    }
```

### List events

GET `/api/v1/cloudron/eventlog` <scope>admin</scope>

Lists all the past events.

The `action` query parameter can be used to list events of a specific action.

The `search` query parameter can be used to do a wildcard ('*search*') on the data field.

This API supports [pagination](#pagination) - use the `page` and `per_page` query parameters to get specific pages.

Response (200):

```
{
    eventlogs: [
        {
            id: <string>,            // unique id for the event
            action: <enum>,          // see below
            source: <object>,        // originator of this event
            data: <object>,          // value depends on action. see below
            creationTime: <date>     // ISO-8601 date in UTC
        },
        ....
    ]
}
```

`action` is one of the values below:

| Event name        | Data                                                 |
| ----------------- |:-----------------------------------------------------|
| cloudron.activate | none                                                 |
| app.configure     | appId                                                |
| app.install       | appId, location, manifest, backupId                  |
| app.restore       | appId                                                |
| app.uninstall     | appId                                                |
| app.update        | appId, toManifest, fromManifest, force               |
| backup.finish     | errorMessage, backupId                               |
| backup.start      | none                                                 |
| certificate.renew | domain, errorMessage                                 |
| settings.climode  | enabled                                              |
| cloudron.start    | version                                              |
| cloudron.update   | boxUpdateInfo (sourceTarballUrl, version, changelog) |
| user.add          | userId, email                                        |
| user.login        | authType (oauth, ldap), appId, mailboxId             |
| user.remove       | userId                                               |
| user.update       | userId                                               |

`source` contains information on the originator of the action. For example, for user.login, this contains the IP address, the appId and the authType (ldap or oauth).

`data` contains information on the event itself. For example, for user.login, this contains the userId that logged in. For app.install, it contains the manifest and location of the app that was installed.

To list all the app installation events:

```
curl -X GET -H 'Authorization: Bearer cb0463455a6606482be7956fc3abd53330ae23244e3492cda3914a2c5154c47e' https://my.example.com/api/v1/cloudron/eventlog?action=app.install
```

## Domains

Cloudron domains hold the necessary settings required to automate DNS setup. When installing an app,
the admin can select the domain to install.

### Create domain

POST `/api/v1/domains` <scope>admin</scope>

Creates a new domain.

Request:
```
{
    "name": <string>,            // required: the domain name
    "provider": <string>         // required: 'route53', 'gcdns' or 'digitalocean' or 'cloudflare' or 'noop' or 'manual'
    "config": <object>,          // required: provider specific DNS settings
    "zoneName": <string>,       // optional: the DNS zone name. defaults to the domain name itself
    "fallbackCertificate": {    // optional
        "cert": <string>        // certificate
        "key":  <string>        // certificate private key
    }
}
```

The value of `config` depends on the `provider`:

| Provider          | config                                               |
| ----------------- |:-----------------------------------------------------|
| cloudflare        | token (API token), email                             |
| digitalocean      | token (API token)                                    |
| gcdns             | projectId, credentials.client\_email, credentials.private\_key |
| manual            | wildcard (boolean)                                   |
| noop              |                                                      |
| route53           | accessKeyId, secretAccessKey, region, endpoint       |

When adding a domain, the credentials are validated. As a result, this requires the `provider` service
to be online and functional.

Response (201):
```
{
    domain: <string>,
    config: <object>
}
```

### Get domain

GET `/api/v1/domains/:domain` <scope>admin</scope>

Gets an existing domain with name `domain`.

Response (200):
```
{
    "name": <string>,            // required: the domain name
    "provider": <string>         // required: 'route53', 'gcdns' or 'digitalocean' or 'cloudflare' or 'noop' or 'manual'
    "config": <object>,          // required: provider specific DNS settings
    "zoneName": <string>,       // optional: the DNS zone name. defaults to the domain name itself
    "fallbackCertificate": {    // optional
        "cert": <string>        // certificate
        "key":  <string>        // certificate private key
    }
}
```

### Update domain

PUT `/api/v1/domains/:domain` <scope>admin</scope>

Request:
```
{
    "provider": <string>        // required: 'route53', 'gcdns' or 'digitalocean' or 'cloudflare' or 'noop' or 'manual'
    "config": <object>,         // required: provider specific DNS settings
    "zoneName": <string>,       // optional: the DNS zone name. defaults to the domain name itself
    "fallbackCertificate": {    // optional
        "cert": <string>        // certificate
        "key":  <string>        // certificate private key
    }
}
```

When updating a domain, the credentials are validated. As a result, this requires the `provider` service
to be online and functional.

Response (204):
```
{
}
```

### List domains

GET `/api/v1/domains` <scope>admin</scope>

Lists all domains.

Response (200):
```
{
    domains: [
        {
            "name": <string>,            // required: the domain name
            "provider": <string>         // required: 'route53', 'gcdns' or 'digitalocean' or 'cloudflare' or 'noop' or 'manual'
            "config": <object>,          // required: provider specific DNS settings
            "zoneName": <string>,       // optional: the DNS zone name. defaults to the domain name itself
            "fallbackCertificate": {    // optional
                "cert": <string>        // certificate
                "key":  <string>        // certificate private key
            }
        },
        ...
    ]
}
```

### Delete domain

DELETE `/api/v1/domains/:domain` <scope>admin</scope>

Deletes an existing domain with id `domain`.

Response (204):
```
{}
```

## Groups

Cloudron groups are a mechanism to restrict application access to a subset of users. You can add one or more users
to a group and assign one or more groups to an application. Only users that are members of any of the groups can access the application.

Group membership is dynamic. Users instantly lose or gain access to an application based on their group
membership.

### Create group

POST `/api/v1/groups` <scope>admin</scope>

Creates a new group.

Request:
```
{
    name: <string>
}
```

`name` must be atleast 2 characters. The special built-in group named `admin` has all the
Cloudron administrators.

Response (200):
```
{
    id: <string>,
    name: <string>
}
```

### Get group

GET `/api/v1/groups/:groupId` <scope>admin</scope>

Gets an existing group with id `groupId`.

Response (200):
```
{
    id: <string>,
    name: <string>,
    userIds: [ <string>, ... ]  // list of users that are part of this group
}
```

### Set members

PUT `/api/v1/groups/:groupId/members` <scope>admin</scope>

Sets the members of an existing group with id `groupId`. Note that this replaces the
existing users with the provided userIds.

Request:
```
{
    userIds: [ <string>, ... ] // list of users to be part of this group
}
```

### List groups

GET `/api/v1/groups` <scope>admin</scope>

Lists all groups.

Response (200):
```
{
    groups: [
        {
            id: <string>,
            name: <string>,
            userIds: [ <string>, ... ]  // list of users that are part of this group
        },
        ...
    ]
}
```

### Delete group

DELETE `/api/v1/groups/:groupId` <scope>admin</scope>

Deletes an existing group with id `groupId`.

The special `admin` group cannot be removed.

Response (204):
```
{}
```

## Mail

Cloudron Mail API can be used to configure the email settings for a domain. The API
can configure mailboxes, aliases and lists.

### Enable Outbound

POST `/api/v1/mail` <scope>admin</scope>

Sets the email configuration. The Cloudron has a built-in email server for users.
This configuration can be used to enable or disable the email server. Note that
the Cloudron will always be able to send email on behalf of apps, regardless of
this setting.

Request:
```
{
    "domain": <string>
}
```

### Enable Inbound

POST `/api/v1/mail/:domain/enable` <scope>admin</scope>

Sets the email configuration. The Cloudron has a built-in email server for users.
This configuration can be used to enable or disable the email server. Note that
the Cloudron will always be able to send email on behalf of apps, regardless of
this setting.

Request:
```
{
    "enabled": <boolean>
}
```


### Get Mail configuration

GET `/api/v1/mail/:domain` <scope>admin</scope>

Response(200):
```
{
    "enabled": <boolean>,                // whether incoming mail is enabled
    "catchAll": [ <string> ],            // array of mailbox names
    "mailFromValidation": <boolean>,     // whether MAIL FROM validation is enabled
    "relay": {                     // smtp server via which outbound mail is sent
        provider: <smtp provider>, // cloudron-smtp, external-smtp etc
        host: <string>, // the host name of the SMTP relay
        port: <number>, // the port number of the SMTP relay
        username: <string>, // the username for authenticating with the SMTP relay
        password: <string>  // the password for authenticating with the SMTP relay
    }
}
```

### Set Catch All Address

PUT `/api/v1/mail/:domain/catch_all_address` <scope>admin</scope>

Sets the address(es) to which emails addressed to a non-existent mailbox are forwarded.
Configuring a catch-all address can help avoid losing emails due to misspelling.

Request:
```
{
    "addresses": [ <string> ] // array of mailbox names
}
```

### Set Mail Relay

PUT `/api/v1/mail/:domain/relay` <scope>admin</scope>

Sets the SMTP server through which outbound mails are relayed.

Request:
```
{
    provider: <smtp provider>, // cloudron-smtp, external-smtp etc
    host: <string>, // the host name of the SMTP relay
    port: <number>, // the port number of the SMTP relay
    username: <string>, // the username for authenticating with the SMTP relay
    password: <string>  // the password for authenticating with the SMTP relay
}
```

`provider` is one of the following values:
* `cloudron-smtp`
* `external-smtp`
* `ses-smtp`
* `google-smtp`
* `mailgun-smtp`
* `postmark-smtp`
* `sendgrid-smtp`

Cloudron requires the relay to support `STARTTLS`. Relaying using `SMTPS` (SMTP over TLS) is not supported.

### Set MAIL FROM validation

POST  `/api/v1/mail/:domain/mail_from_validation` <scope>admin</scope>

Enables or disables the mail from header check for outbound mails.

Cloudron only allows authenticated users and apps to send outbound mail. After authentication, it ensures
that the SMTP MAIL FROM header matches either the authenticated username or the aliases of the username. This
prevents apps and users from impersonating using other email ids.

You can disable this to skip the MAIL FROM header check. Note that the Cloudron will never send out emails
if the FROM domain does not match the Cloudron's domain regardless of this setting.

Request:
```
{
    enabled: <boolean>
}
```

Example:
```
curl -X POST -d '{ "enabled": false" }'  -H 'Authorization: Bearer 215841b5943f5432a26ef3a1526f548a40268a92ed9baca5db980be0545da596'  https://my.example.com/api/v1/mail/domain.com/mail_from_validation
```


### Status

GET `/api/v1/mail/:domain/status`   <scope>admin</scope>

### Create user mailbox

POST `/api/v1/mail/:domain/mailboxes`

### Get user mailbox

GET `/api/v1/mail/:domain/mailboxes/:userId`

### Enable user mailbox

POST `/api/v1/mail/:domain/mailboxes/:userId`

### Disable user mailbox

DEL `/api/v1/mail/:domain/mailboxes/:userId`

### List user mailboxes

GET `/api/v1/mail/:domain/mailboxes`

### List aliases

GET `/api/v1/mail/:domain/aliases`

### Get aliases

GET `/api/v1/mail/:domain/aliases/:userId`

### Set aliases

POST `/api/v1/mail/:domain/aliases/:userId`

### List forwarding groups

GET `/api/v1/mail/:domain/lists`

### Create mailing group

POST `/api/v1/mail/:domain/lists`

### Get mailing group

GET `/api/v1/mail/:domain/lists/:groupId`

### Delete mailing group

DEL `/api/v1/mail/:domain/lists/:groupId`

## Profile

### Get apps

GET `/api/v1/user/apps` <scope>profile</scope>

Gets the list of apps that the user has access to.

Response (200):

```
{
    apps: [
        {
            id: <string>,                    // a unique id for the app
            appStoreId: <string>,            // Cloudron App Store Id for updates
            manifest: <manifest>,            // current manifest of the app
            installationState: <enum>,       // See below
            installationProgress: <string>,  // friendly string indicating installation progress
            runState: <enum>,                // see below
            health: <enum>,                  // health of the application
            location: <string>,              // subdomain on which app is installed
            fqdn: <string>,                  // the FQDN of this app
            accessRestriction: null || {     // list of users and groups who can access this application
                users: [ ],
                groups: [ ]
            },
            manifest: <manifest>,            // the application manifest
            portBindings: {                  // mapping for application ports to public ports
            },
            iconUrl: <url>,                  // a relative url providing the icon
            memoryLimit: <number>            // memory constraint in bytes
        },
        ...
    ]
}
```

### Get profile

GET `/api/v1/user/profile` <scope>profile</scope>

Gets the profile information of the token owner. This is useful to verify access tokens.

Response (200):
```
{
    id: <string>,
    username: <string>,
    email: <email>,
    admin: <boolean>,
    displayName: <string>
}
```

### Update profile

POST `/api/v1/user/profile` <scope>profile</scope>

Updates the email or displayName of the token owner.

Request:
```
{
    email: <email>,         // optional
    displayName: <string>   // optional
}
```

Response (204):
```
{}
```

### Update password

POST `/api/v1/user/profile/password` <scope>profile</scope>

Updates the password of the token owner.

Request:
```
{
    password: <string>,     // current password. only required for OAuth tokens
    newPassword: <string>
}
```

Response (204):
```
{}
```

### Enable 2FA

POST `/api/v1/user/profile/twofactorauthentication/enable` <scope>profile</scope>

Enables 2FA for the token owner.

Request:
```
{
    totpToken: <string>  // the totp token
}
```

Response (202):
```
{
}
```

### Set 2FA Secret

POST `/api/v1/user/profile/twofactorauthentication` <scope>profile</scope>

Sets the TOTP secret

Request:
```
{
}
```

Response (201):
```
{
    secret: <secret>,
    qrcode: <qrcode>
```

### Disable 2FA

POST `/api/v1/user/profile/twofactorauthentication/disable` <scope>profile</scope>

Disables 2FA for the token owner.

Request:
```
{
}
```

Response (202):
```
{
}
```

## Settings

### Get Appstore Config

GET `/api/v1/settings/appstore_config` <scope>admin</scope>

Response (200):
```
{
    userId: <string>,            // the appstore userId
    token:  <string>,            // appstore token
    cloudronId: <string>         // cloudron id
}
```

### Set Appstore Config

POST  `/api/v1/settings/appstore_config` <scope>admin</scope>

Sets the credentials used for the Cloudron App Store.

Request:
```
{
    userId: <string>,     // the appstore userId
    token:  <string>      // token from appstore
}
```

You can get the `userId` and `token` by sending a `/api/v1/login` POST request to `api.cloudron.io`
with the `email` and `password` fields set in the request like so:
```
curl -X POST -H 'Content-Type: application/json' -d '{"email":"girish@cloudron.io", "password":"supersecretpassword"}' https://api.cloudron.io/api/v1/login
```

The above request will contain a `userId` and a `token` that can now be used to setup the Appstore account on the Cloudron.

Example:
```
curl -k -X POST -H "Content-Type: application/json" -d '{"userId":"2e2259a5fa81", "token":"tokenfromaboverequest"}' 'https://my.smartserver.space/api/v1/settings/appstore_config?access_token=cloudronaccesstoken'
```

### Get auto update pattern

GET `/api/v1/settings/autoupdate_pattern` <scope>admin</scope>

Gets the auto update pattern that the Cloudron uses to automatically update itself and installed apps.

Patterns are matched based on the Cloudron's [timezone](#get-timezone).

Response (200):
```
{
    pattern: <string>            // a cron pattern
}
```

### Set auto update pattern

POST  `/api/v1/settings/autoupdate_pattern` <scope>admin</scope>

Sets the auto update pattern that the Cloudron uses to automatically update itself and installed apps.

Request:
```
{
    pattern: <string>     // a cron pattern
}
```

`pattern` has the format listed in the [node-cron](https://github.com/ncb000gt/node-cron#cron-ranges) page.
Note that unlike classic crontab format, the pattern contains seconds as the first part.

Setting pattern to `never` disables auto update.

Some examples of patterns are:

* `00 00 1,3,5,23 * * *` would run updates at 1am, 3am, 5am, 11pm every night.
* `0 030 4 1,15 * 5` would run updates at 4:30 am on the 1st and 15th of each month, plus every Friday.

Patterns are matched based on the Cloudron's [timezone](#get-timezone).

### Get Cloudron Avatar

GET `/api/v1/settings/cloudron_avatar` <scope>admin</scope>

Gets the Cloudron avatar image as `Content-Type: image/png`.

Note that the avatar is also available without authentication using the [Get avatar](#get-avatar) API.

Response (200):
```
Content-Type: image/png
```

### Set Cloudron Avatar

POST `/api/v1/settings/cloudron_avatar` <scope>admin</scope>

Sets the avatar of the Cloudron.

The request is sent as `multipart/form-data`. It must contain a field named `avatar` and must be a `png`.

Example:
```
curl -X POST -F "avatar=@./avatar.png"  -H 'Authorization: Bearer 215841b5943f5432a26ef3a1526f548a40268a92ed9baca5db980be0545da596'  https://my.example.com/api/v1/settings/cloudron_avatar
```

### Get Backup Configuration

GET `/api/v1/settings/backup_config` <scope>admin</scope> <scope>internal</scope>

Gets the credentials used to upload backups.

Response(200):
```
{
  "provider": <string>,         // 'caas' or 's3' or 'filesystem'
  "key": <string>,              // encryption key
  "retentionSecs": <number>,    // required: how long to retain backups
  "region": <string>,           // s3 region
  "bucket": <string>,           // s3 bucket name
  "prefix": <string>,           // s3 bucket prefix
  "token": <string>,            // 'caas' specific token
  "backupFolder": <string>,     // 'filesystem' specific backup directory
  "format": "tgz" | "flat-file" // backup storage format
}
```

### Set Backup Configuration

POST `/api/v1/settings/backup_config` <scope>admin</scope> <scope>internal</scope>

Sets the credentials used to upload backups.

Request:
```
{
    "provider": "s3|filesystem",
    "key": <string>,               // backup encryption key
    "retentionSecs": <number>      // required: how long to retain backups
    "format": "tgz" | "flat-file", // backup storage format

    "bucket": <string>,          // S3: bucket
    "prefix": <string>,          // S3: prefix in bucket
    "accessKeyId": <string>,     // S3: access key id
    "secretAccessKey": <string>, // S3: secret access key

    "backupFolder": <string>     // filesystem: directory inside cloudron to store backups
}
```

### Set fallback Certificate

POST `/api/v1/settings/certificate` <scope>admin</scope> <scope>internal</scope>

Sets the fallback TLS certificate to use if automatic certificate generation or renewal fails.

The fallback certificate only applies to Cloudrons running on a custom domain.

The Cloudron automatically installs and renews certificates for all subdomains using Let's Encrypt.
The fallback certificate is used if Let's Encrypt fails.

Request:
```
{
    cert: <pem encoded string>,   // TLS certificate including the full chain
    key:  <pem encoded string>    // TLS key
}
```

<!--
See #47

### Set `my` subdomain certification

POST `/api/v1/settings/admin_certificate` <scope>admin</scope> <scope>internal</scope>

Sets the certificate to use for the `my` subdomain.

The `my` subdomain certificate only applies to Cloudrons running on a custom domain.

Request:
```
{
    cert: <pem encoded string>,   // TLS certificate including the full chain
    key:  <pem encoded string>    // TLS key
}
```
-->

### Get Cloudron Name

GET `/api/v1/settings/cloudron_name` <scope>admin</scope>

Gets the name of the Cloudron.

Note that the name is also available without authentication using the [Get status](#get-status) API.

```
Response (200):
{
    name: <string>
}
```

### Set Cloudron Name

POST  `/api/v1/settings/cloudron_name` <scope>admin</scope>

Sets the name of the Cloudron.

The Cloudron name is shown in the title bar and all the login screens. It has a maximum length of 32 characters.

Request:
```
{
    name: <string>
}
```

### Get Platform Config

GET `/api/v1/settings/platform_config` <scope>admin</scope>

Response (200):
```
{
    mysql: { },
    mongodb: { },
    postgresql: { },
    mysql: { },
    mail: { }
}
```

### Set Platform Config

POST  `/api/v1/settings/platform_config` <scope>admin</scope>

Request:
```
{
    mysql: {
        memory: <number>
        memorySwap: <number>
    },
    postgresql: {
        memory: <number>
        memorySwap: <number>
    },
    mongodb: {
        memory: <number>
        memorySwap: <number>
    },
    mail: {
        memory: <number>
        memorySwap: <number>
    }
}
```

This can be used to persist custom memory limits on the built-in addon containers. For example, to bump the mysql memory limit
to 500MB:

```
curl -X POST -H "Content-Type: application/json" -d '{"mysql": { "memory": 524288000, "memorySwap": 524288000 } }' https://my.example.com/api/v1/settings/platform_config?access_token=77379e1f72cff51218f226fb
```

### Get timezone

GET `/api/v1/settings/time_zone` <scope>admin</scope>

Gets the timezone of the Cloudron.

Timezone is automatically set based on the IP address from where the Cloudron was activated. This timezone is used with the [auto update pattern](#get-auto-update-pattern) to trigger updates at the
correct time.

```
Response (200):
{
    timeZone: <string>          // the timezone
}
```

### Set timezone

POST  `/api/v1/settings/time_zone` <scope>admin</scope>

Sets the time zone of the Cloudron.

Timezone is automatically set based on the IP address from where the Cloudron was activated. This timezone is used with the [auto update pattern](#get-auto-update-pattern) to trigger updates at the
correct time.

See the [Tz database](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones) for a list of valid values.

Request:
```
{
    timeZone: <string>
}
```

## Users

### Create user

POST `/api/v1/users` <scope>admin</scope>

Creates a new user.

Request:
```
{
    email: <email>,         // required
    username: <string>,     // optional
    displayName: <string>,  // optional
    password: <password>    // optional
}
```

`username` has to be at least two characters long and must be alphanumeric. If unspecified, the new user
can pick any available name on first sign up. For security, `username` cannot be changed once set.
Some apps (incorrectly) use the `username` as their unique identifier. As a result, it might mistake a newly created user as a previous user with the same username. If you want to reset the username, delete the existing
the user and create a new one again.

`displayName` may consist of one or more words to specify the first name and surname.

`password` can be used to set the new user's password. If a password is not provided, it is auto-generated.

Response (201):
```
{
    id: <string>,
    username: <string>,
    displayName: <string>,
    email: <email>,
    groupIds: [ <string>, ... ]
    resetToken: <string>    // User can sign up at https://my.example.com/api/v1/session/account/setup.html?reset_token=<resetToken>
}
```

### Get user

GET `/api/v1/users/:userId` <scope>admin</scope>

Gets detailed information about a specific user with id `userId`.

Response (200):
```
{
    id: <string>,
    username: <string>,
    email: <email>,
    groupIds: [ <string>, ... ],   // list of groups this user is part of
    admin: <boolean>,              // a boolean indicating if this user is an admin
    displayName: <string>
}
```

### List users

GET `/api/v1/users` <scope>admin</scope>

Lists all users.

Response (200):
```
{
    users: [
        {
            id: <string>,
            username: <string>,
            email: <email>,
            displayName: <string>,
            groupIds: [ <string>, ... ],   // list of groups this user is part of
            admin: <boolean>               // a boolean indicating if this user is an admin
        },
        ...
    ]
}
```

### Update user

POST `/api/v1/users/:userId` <scope>admin</scope>

Modify user's email or display name. As noted in [Create user](#create-user), username
cannot be changed.

Request:
```
{
    email: <email>,              // optional
    displayName: <displayName>   // optional
}

```

Response (204):
```
{}
```

### Update user password

POST `/api/v1/users/:userId/password` <scope>admin</scope>

Modify user's password.

Request:
```
{
    password: <password>
}
```

Response (204):
```
{}
```

### Create invitation link

POST `/api/v1/users/:userId/create_invite` <scope>admin</scope>

Creates an invitation link to an existing user.

A re-invite call invalidates any previous invite links. The invitation link can be constructed based on the resetToken in the response.

Request:
```
{}
```

Response (200):
```
{
    resetToken: <string>   // // User can sign up at https://my.example.com/api/v1/session/account/setup.html?reset_token=<resetToken>
}
```

### Send invitation link

POST `/api/v1/users/:userId/send_invite` <scope>admin</scope>

Sends an invitation link to an existing user. This call will fail if an invitation link was not generated previously.

Request:
```
{}
```

Response (200):
```
{
}
```

### Set groups

PUT `/api/v1/users/:userId/groups` <scope>admin</scope>

Sets the groups for the user with id `userId`.

Groups are identified by groupIds which can be retrieved using the
[Groups API](#list-all-groups).

An admin cannot remove himself from the special `admin` group. This will result in a response code of 403.

Note that this call will replace the current groups for this user, it does **not** merge the provided ones with the current groups for that user.

Request:
```
{
    groupIds: [ <string>, ... ]
}

```
Response (204):
```
{}
```

### Delete user

DELETE `/api/v1/users/:userId` <scope>admin</scope>

Deletes user with id `userId`.

A user cannot remove himself, this will result in a response code of 403.

A deleted user will not be able to login to any app anymore. Currently, apps are not notified of a user
deletion and any user-specific data data will persist on the app.

Note that applications may cache user credentials (for example, as a browser session cookie) and thus the
effect of a deletion may not be immediately visible until the user logs out.

Response (204):
```
{}
```
