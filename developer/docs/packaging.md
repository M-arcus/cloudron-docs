# Packaging

## Overview

This tutorial outlines how to package an existing web application for the Cloudron.

If you are aware of Docker and Heroku, you should feel at home packaging for the
Cloudron. Roughly, the steps involved are:

* Create a Dockerfile for your application. If your application already has a Dockerfile, it
  is a good starting point for packaging for the Cloudron. By virtue of Docker, the Cloudron
  is able to run apps written in any language/framework.

* Create a CloudronManifest.json that provides information like title, author, description
   etc. You can also specify the addons (like database) required
  to run your app. When the app runs on the Cloudron, it will have environment
  variables set for connecting to the addon.

* Test the app on your Cloudron with the CLI tool.

* Optionally, submit the app to [Cloudron App Store](/appstore.html).

## Prerequisites

### Install CLI tool

The Cloudron CLI tool allows you to install, configure and test apps on your Cloudron.

Installing the CLI tool requires [node.js](https://nodejs.org/) and
[npm](https://www.npmjs.com/). You can then install the CLI tool using the following
command:

```
    sudo npm install -g cloudron
```

Note: Depending on your setup, you can run the above command without `sudo`.

### Login to Cloudron

The `cloudron` command should now be available in your path.

You can login to your Cloudron now:

```
$ cloudron login
Cloudron Hostname: my-craft.selfhost.io

Enter credentials for my-craft.selfhost.io:
Username: girish
Password:
Login successful.
```

## Basic app

We will first package a very simple app to understand how the packaging works.
You can clone this app from https://git.cloudron.io/cloudron/tutorial-basic.

### The server

The basic app server is a very simple HTTP server that runs on port 3000.
While the server in this tutorial uses node.js, you can write your server
in any language you want.

```server.js
var http = require("http");

var server = http.createServer(function (request, response) {
  response.writeHead(200, {"Content-Type": "text/plain"});
  response.end("Hello World\n");
});

server.listen(3000);

console.log("Server running at port 3000");
```

### Dockerfile

The Dockerfile contains instructions on how to create an image for your application.

```Dockerfile
FROM cloudron/base:1.0.0

ADD server.js /app/code/server.js

CMD [ "/usr/local/node-8.12.0/bin/node", "/app/code/server.js" ]
```

The `FROM` command specifies that we want to start off with Cloudron's [base image](/developer/baseimage/).
All Cloudron apps **must** start from this base image. This approach conserves space on the Cloudron since
Docker images tend to be quite large and also helps us to do a security audit on apps more easily.

The `ADD` command copies the source code of the app into the directory `/app/code`. There is nothing special
about the `/app/code` directory and it is merely a convention we use to store the application code.

The `CMD` command specifies how to run the server. The base image already contains Node.js version 8.12.0 so we just use that.

This Dockerfile can be built and run locally as:
```
docker build -t tutorial .
docker run -p 3000:3000 -t tutorial
```

### Manifest

The `CloudronManifest.json` specifies

* Information for installing and running the app on the Cloudron. This includes fields like addons, httpPort, tcpPorts.

* Information about displaying the app on the Cloudron App Store. For example, fields like title, author, description.

Create the CloudronManifest.json using `cloudron init` as follows:

```
$ cloudron init
```

The above command creates a CloudronManifest.json:

File ```tutorial/CloudronManifest.json```

```json
{
  "id": "io.cloudron.tutorial",
  "title": "Tutorial App",
  "author": "John Doe",
  "description": "file://DESCRIPTION.md",
  "changelog": "file://CHANGELOG",
  "tagline": "Changing the world one app at a time",
  "version": "0.1.0",
  "healthCheckPath": "/",
  "httpPort": 3000,
  "addons": {
    "localstorage": {}
  },
  "manifestVersion": 2,
  "website": "https://cloudron.io",
  "contactEmail": "support@cloudron.io",
  "icon": "",
  "tags": [
    "changme"
  ],
  "mediaLinks": [ ]
}
```

You can read in more detail about each field in the [Manifest reference](/developer/manifest/). The
`localstorage` addon allows the app to store files in `/app/data`. We will explore addons further further
down in this tutorial.

Additional files created by `init` are:
* `DESCRIPTION.md` - A markdown file providing description of the app for the Cloudron App Store.
* `CHANGELOG` - A file containing change information for each version released to the Cloudron App Store. This
  information is shown when the user updates the app.

## Installing

We now have all the necessary files in place to build and deploy the app to the Cloudron.

Cloudron packages can be built using one of the two ways:

* [Build Service](#build-service)
* [Private Build](#private-build)

### Build Service

Building, pushing and pulling docker images can be very bandwidth and CPU intensive. To alleviate this
problem, apps are built using the `build service` which uses `cloudron.io` account credentials.

!!! warning "Public Docker Registry"
    As of this writing, the build service uses the public Docker registry and the images that are built
    can be downloaded by anyone. This means that your source code will be viewable by others. If you are
    building closed source software, we recommend using [private builds](#private-build) instead.

Initiate a build using ```cloudron build```:

```
$ cloudron build
Building io.cloudron.tutorial@0.0.1

cloudron.io login:
Email: ramakrishnan.girish@gmail.com         # cloudron.io account
Password:                                    # Enter password
Login successful.

Build scheduled with id e7706847-f2e3-4ba2-9638-3f334a9453a5
Waiting for build to begin, this may take a bit...
Downloading source
Building
Step 1 : FROM cloudron/base:1.0.0
 ---> be9fc6312b2d
Step 2 : ADD server.js /app/code/server.js
 ---> 10513e428d7a
Removing intermediate container 574573f6ed1c
Step 3 : CMD /usr/local/node-8.12.0/bin/node /app/code/server.js
 ---> Running in b541d149b6b9
 ---> 51aa796ea6e5
Removing intermediate container b541d149b6b9
Successfully built 51aa796ea6e5
Pushing
The push refers to a repository [docker.io/cloudron/img-062037096d69bbf3ffb5b9316ad89cb9] (len: 1)
Pushed 51aa796ea6e5
Pushed 10513e428d7a
Image already exists be9fc6312b2d
Image already exists a0261a2a7c75
Image already exists f9d4f0f1eeed
Image already exists 2b650158d5d8
e7706847-f2e3-4ba2-9638-3f334a9453a5: digest: sha256:8241d68b65874496191106ecf2ee8f3df2e05a953cd90ff074a6f8815a49389c size: 26098
Build succeeded
Success
```

Now that we have built the image, we can install our latest build on the Cloudron
using the following command:

```
$ cloudron install
Using cloudron craft.selfhost.io
Using build 76cebfdd-7822-4f3d-af17-b3eb393ae604 from 1 hour ago
Location: tutorial                         # This is the location into which the application installs
App is being installed with id: 4dedd3bb-4bae-41ef-9f32-7f938995f85e

 => Waiting to start installation
 => Registering subdomain .
 => Verifying manifest .
 => Downloading image ..............
 => Creating volume .
 => Creating container
 => Setting up collectd profile ................
 => Waiting for DNS propagation ...

App is installed.
```

Open the app in your default browser:
```
cloudron open
```

You should see `Hello World`.

### Private Build

Cloudron apps can be built without using the [build service](#build-service)
using a local installation of Docker.

```
$ docker build -t girish/hello-world:0.1
$ docker tag girish/hello-world:0.1 quay.io/girish/hello-world:0.1
```

The image can then be pushed to any Docker container registry:

```
$ docker push quay.io/girish/hello-world:0.1
```

When using the public Docker Hub, Cloudron already has access to the pushed image and
no special action is required. However, when using a private Docker registry like [Quay](https://quay.io), Amazon ECR,
the Cloudron needs to be given access to the image. For this, we must login
using the private docker registry credentials by SSHing into the Cloudron server:

```
root@my:~# su -c 'docker login quay.io' yellowtent
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to https://hub.docker.com to create one.
Username: girish
Password:
Login Succeeded
```

The app can then be installed on the Cloudron using the following command:

```
$ cloudron install --image quay.io/girish/hello-world:0.1
Location (subdomain): hello
App is being installed with id: 4dedd3bb-4bae-41ef-9f32-7f938995f85e

 => Waiting to start installation
 => Registering subdomain .
 => Verifying manifest .
 => Downloading image ..............
 => Creating volume .
 => Creating container
 => Setting up collectd profile ................
 => Waiting for DNS propagation ...

App is installed.
```

Open the app in your default browser:
```
cloudron open
```

You should see `Hello World`.

## Testing

The application testing cycle involves `cloudron build` and `cloudron install`.
Note that `cloudron install` updates an existing app in place.

You can view the logs using `cloudron logs`. When the app is running you can follow the logs
using `cloudron logs -f`.

For example, you can see the console.log output in our server.js with the command below:

```
$ cloudron logs
Using cloudron craft.selfhost.io
16:44:11 [main] Server running at port 3000
```

It is also possible to run a *shell* and *execute* arbitrary commands in the context of the application
process by using `cloudron exec`. By default, exec simply drops you into an interactive bash shell with
which you can inspect the file system and the environment.

```
$ cloudron exec
```

You can also execute arbitrary commands:
```
$ cloudron exec env # display the env variables that your app is running with
```

#### Debugging

An app can be placed in `debug` mode by passing `--debug` to `cloudron install` or `cloudron configure`.
Doing so, runs the app in a non-readonly rootfs and unlimited memory. By default, this will also ignore
the `RUN` command specified in the Dockerfile. The developer can then interactively test the app and
startup scripts using `cloudron exec`.

This mode can be used to identify the files being modified by your application - often required to
debug situations where your app does not run on a readonly rootfs. Run your app using `cloudron exec`
and use `find / -mmin -30` to find file that have been changed or created in the last 30 minutes.

You can turn off debugging mode using `cloudron configure --no-debug`.

## Addons

### Filesystem

The application container created on the Cloudron has a `readonly` file system. Writing to any location
other than the below will result in an error:

* `/tmp` - Use this location for temporary files. The Cloudron will cleanup any files in this directory
  periodically.

* `/run` - Use this location for runtime configuration and dynamic data. These files should not be expected
  to persist across application restarts (for example, after an update or a crash).

* `/app/data` - Use this location to store application data that is to be backed up. To use this location,
  you must use the [localstorage](/developer/addons/#localstorage) addon. For convenience, the initial CloudronManifest.json generated by
  `cloudron init` already contains this addon.

### Database

Most web applications require a database of some form. In theory, it is possible to run any
database you want as part of the application image. This is, however, a waste of server resources
should every app runs it's own database server.

Cloudron currently provides [mysql](/developer/addons/#mysql), [postgresql](/developer/addons/#postgresql),
[mongodb](/developer/addons/#mongodb), [redis](/developer/addons/#redis) database addons. When choosing
these addons, the Cloudron will inject environment variables that contain information on how to connect
to the addon.

See https://git.cloudron.io/cloudron/tutorial-redis for a simple example of how redis can be used by
an application. The server simply uses the environment variables to connect to redis.

### Email

Cloudron applications can send email using the `sendmail` addon. Using the `sendmail` addon provides
the SMTP server and authentication credentials in environment variables.

Cloudron applications can also receive mail via IMAP using the `recvmail` addon.

### Authentication

The Cloudron has a centralized panel for managing users and groups. If possible, apps should always be
integrated with the Cloudron usermanagement to provide a better out-of-the box experience.

Apps can integrate with the Cloudron authentication system using LDAP or OAuth 2.0. See the
[LDAP](/developer/addons/#ldap) and [OAuth](/developer/addons/#oauth)
pages for more details.

See [tutorial-ldap](https://git.cloudron.io/cloudron/tutorial-ldap) for a simple example of how to authenticate via LDAP.

## Best practices

### No Setup

A Cloudron app is meant to instantly usable after installation. For this reason, Cloudron apps must not
show any setup screen after installation and should simply choose reasonable defaults.

Databases, email configuration should be automatically picked up from the environment variables using
addons.

### Docker

Cloudron uses Docker in the backend, so the package build script is a regular `Dockerfile`.

The app is run as a read-only docker container. Only `/run` (dynamic data), `/app/data` (backup data) and `/tmp` (temporary files) are writable at runtime. Because of this:

*   Install any required packages in the Dockerfile.
*   Create static configuration files in the Dockerfile.
*   Create symlinks to dynamic configuration files under `/run` in the Dockerfile.

#### Source directory

By convention, Cloudron apps install the source code in `/app/code`. Do not forget to create the directory for the code of the app:
```sh
RUN mkdir -p /app/code
WORKDIR /app/code
```

#### Download archives

When packaging an app you often want to download and extract archives (e.g. from github).
This can be done in one line by combining `wget` and `tar` like this:

```docker
ENV VERSION 1.6.2
RUN wget "https://github.com/FreshRSS/FreshRSS/archive/${VERSION}.tar.gz" -O - \
    | tar -xz -C /app/code --strip-components=1
```

The `--strip-components=1` causes the topmost directory in the archive to be skipped.

Always pin the download to a specific tag or commit instead of using `HEAD` or `master`
so that the builds are reasonably reproducible.

#### Applying patches

To get the app working in Cloudron, sometimes it is necessary to patch the original sources. Patch is a safe way to modify sources, as it fails when the expected original sources changed too much.

First create a backup copy of the full sources (to be able to calculate the differences):

```sh
cp -a extensions extensions-orig
```

Then modify the sources in the original path and when finished, create a patch like this:

```sh
diff -Naru extensions-orig/ extensions/ > change-ttrss-file-path.patch
```

Add and apply this patch to the sources in the Dockerfile:

```docker
ADD change-ttrss-file-path.patch /app/code/change-ttrss-file-path.patch
RUN patch -p1 -d /app/code/extensions < /app/code/change-ttrss-file-path.patch
```

The `-p1` causes patch to ignore the topmost directory in the patch.

### Process manager

Docker supports restarting processes natively. Should your application crash, it will be restarted
automatically. If your application is a single process, you do not require any process manager.

Use supervisor, pm2 or any of the other process managers if you application has more then one component.
This **excludes** web servers like apache, nginx which can already manage their children by themselves.
Be sure to pick a process manager that [forwards signals](#sigterm-handling) to child processes.

### Automatic updates

Some apps support automatic updates by overwriting themselves. A Cloudron app cannot overwrite itself
because of the read-only file system. For this reason, disable auto updates for app and let updates be
triggered through the Cloudron App Store. This ties in better to the Cloudron's update and restore approach
should something go wrong with the update.

### Logging

Cloudron applications stream their logs to stdout and stderr. Logging to stdout has many advantages:

* App does not need to rotate logs and the Cloudron takes care of managing logs.
* App does not need special mechanism to release log file handles (on a log rotate).
* Integrates better with tooling like cloudron cli.

In practice, this ideal is hard to achieve. Some programs like apache simply don't log to stdout.
In such cases, simply log to a subdirectory in  `/run` (two levels deep) into files with `.log`
extension and Cloudron will autorotate the logs.

### supervisor

Supervisor can be configured to send the app's output to stdout as follows:

```
[program:app]
stdout_logfile=/dev/stdout
stdout_logfile_maxbytes=0
stderr_logfile=/dev/stderr
stderr_logfile_maxbytes=0
```

### Memory

By default, applications get 256MB RAM (including swap). This can be changed using the `memoryLimit`
field in the manifest.

Design your application runtime for concurrent use by 50 users. The Cloudron is not designed for
concurrent access by 100s or 1000s of users.

An app can determine it's memory limit by reading `/sys/fs/cgroup/memory/memory.limit_in_bytes`.
For example, to spin one worker for every 150M RAM available to the app:

```
memory_limit=$(cat /sys/fs/cgroup/memory/memory.limit_in_bytes)
worker_count=$((memory_limit/1024/1024/150)) # 1 worker for 150M
worker_count=$((worker_count > 8 ? 8 : worker_count )) # max of 8
worker_count=$((worker_count < 1 ? 1 : worker_count )) # min of 1
```

### Authentication

Apps should integrate with the Cloudron authentication system using LDAP or OAuth 2.0. See the
[LDAP](/developer/addons/#ldap) and [OAuth](/developer/addons/#oauth)
pages for more details. This saves the user from having to manage separate set of credentials for each app.

### Start script

Many apps do not launch the server directly, as we did in our basic example. Instead, they execute
a `start.sh` script (named so by convention) which is used as the app entry point.

At the end of the Dockerfile you should add your start script (`start.sh`) and set it as the default command.
Ensure that the `start.sh` is executable in the app package repo. This can be done with `chmod +x start.sh`.
```docker
ADD start.sh /app/code/start.sh
CMD [ "/app/code/start.sh" ]
```

#### One-time init

One common pattern is to initialize the data directory with some commands once depending on the existence of a special `.initialized` file.

```sh
if ! [ -f /app/data/.initialized ]; then
  echo "Fresh installation, setting up data directory..."
  # Setup commands here
  touch /app/data/.initialized
  echo "Done."
fi
```

To copy over some files from the code directory you can use the following command:

```sh
rsync -a /app/code/config/ /app/data/config/
```

#### chown data files

Since the app containers use other user ids than the host, it is sometimes necessary to change the permissions on the data directory:

```sh
chown -R cloudron.cloudron /app/data
```

For Apache+PHP apps you might need to change permissions to `www-data.www-data` instead.

#### Persisting random values

Some apps need a random value that is initialized once and does not change afterwards (e.g. a salt for security purposes). This can be accomplished by creating a random value and storing it in a file in the data directory like this:

```sh
if ! [ -e /app/data/.salt ]; then
  dd if=/dev/urandom bs=1 count=1024 2>/dev/null | sha1sum | awk '{ print $1 }' > /app/data/.salt
fi
SALT=$(cat /app/data/.salt)
```

#### Generate config

Addon information (mail, database) exposed as environment  are subject to change across restarts and an application must use these values directly (i.e not cache them across restarts). For this reason, it usually regenerates any config files with the current database settings on each invocation.

First create a config file template like this:
```sh
    ... snipped ...
    'mysql' => array(
        'driver'    => 'mysql',
        'host'      => '##MYSQL_HOST',
        'port'      => '##MYSQL_PORT',
        'database'  => '##MYSQL_DATABASE',
        'username'  => '##MYSQL_USERNAME',
        'password'  => '##MYSQL_PASSWORD',
        'charset'   => 'utf8',
        'collation' => 'utf8_general_ci',
        'prefix'    => '',
    ),
    ... snipped ...
```

Add the template file to the Dockerfile and create a symlink to the dynamic configuration file as follows:

```docker
ADD database.php.template /app/code/database.php.template
RUN ln -s /run/paperwork/database.php /app/code/database.php
```

Then in `start.sh`, generate the real config file under `/run` from the template like this:

```sh
sed -e "s/##MYSQL_HOST/${CLOUDRON_MYSQL_HOST}/" \
    -e "s/##MYSQL_PORT/${CLOUDRON_MYSQL_PORT}/" \
    -e "s/##MYSQL_DATABASE/${CLOUDRON_MYSQL_DATABASE}/" \
    -e "s/##MYSQL_USERNAME/${CLOUDRON_MYSQL_USERNAME}/" \
    -e "s/##MYSQL_PASSWORD/${CLOUDRON_MYSQL_PASSWORD}/" \
    -e "s/##REDIS_HOST/${CLOUDRON_REDIS_HOST}/" \
    -e "s/##REDIS_PORT/${CLOUDRON_REDIS_PORT}/" \
    /app/code/database.php.template > /run/paperwork/database.php
```

#### Non-root user

The cloudron runs the `start.sh` as root user. This is required for various commands like `chown` to
work as expected. However, to keep the app and cloudron secure, always run the app with the least
required permissions.

The `gosu` tool lets you run a binary with a specific user/group as follows:

```sh
/usr/local/bin/gosu cloudron:cloudron node /app/code/.build/bundle/main.js
```

#### SIGTERM handling

bash, by default, does not automatically forward signals to child processes. This would mean that a SIGTERM sent to the parent processes does not reach the children. For this reason, be sure to `exec` as the
last line of the start.sh script. Programs like gosu, nginx, apache do proper SIGTERM handling.

For example, start apache using `exec` as below:

```sh
echo "Starting apache"
APACHE_CONFDIR="" source /etc/apache2/envvars
rm -f "${APACHE_PID_FILE}"
exec /usr/sbin/apache2 -DFOREGROUND
```

### Popular stacks

#### Apache

Apache requires some configuration changes to work properly with Cloudron. The following commands configure Apache in the following way:

* Disable all default sites
* Print errors into the app's log and disable other logs
* Limit server processes to `5` (good default value)
* Change the port number to Cloudrons default `3000`

```docker
RUN rm /etc/apache2/sites-enabled/* \
    && sed -e 's,^ErrorLog.*,ErrorLog "/dev/stderr",' -i /etc/apache2/apache2.conf \
    && sed -e "s,MaxSpareServers[^:].*,MaxSpareServers 5," -i /etc/apache2/mods-available/mpm_prefork.conf \
    && a2disconf other-vhosts-access-log \
    && echo "Listen 3000" > /etc/apache2/ports.conf
```

Afterwards, add your site config to Apache:

```docker
ADD apache2.conf /etc/apache2/sites-available/app.conf
RUN a2ensite app
```

In `start.sh` Apache can be started using these commands:

```sh
echo "Starting apache..."
APACHE_CONFDIR="" source /etc/apache2/envvars
rm -f "${APACHE_PID_FILE}"
exec /usr/sbin/apache2 -DFOREGROUND
```

#### Nginx

`nginx` is often used as a reverse proxy in front of the application, to dispatch to different backend programs based on the request route or other characteristics. In such a case it is recommended to run nginx and the application through a process manager like `supervisor`.

Example nginx supervisor configuration file:
```
[program:nginx]
directory=/tmp
command=/usr/sbin/nginx -g "daemon off;"
user=root
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
```

The nginx configuration, provided with the base image, can be used by adding an application specific config file under `/etc/nginx/sites-enabled/` when building the docker image.

```
ADD <app config file> /etc/nginx/sites-enabled/<app config file>
```

Since the base image nginx configuration is unpatched from the ubuntu package, the application configuration has to ensure nginx is using `/run/` instead of `/var/lib/nginx/` to support the read-only filesystem nature of a Cloudron application.

Example nginx app config file:
```
client_body_temp_path /run/client_body;
proxy_temp_path /run/proxy_temp;
fastcgi_temp_path /run/fastcgi_temp;
scgi_temp_path /run/scgi_temp;
uwsgi_temp_path /run/uwsgi_temp;

server {
  listen 3000;

  root /app/code/dist;

  location /api/v1/ {
    proxy_pass http://127.0.0.1:8001;
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";
    proxy_read_timeout 86400;
  }
}

```

#### PHP

PHP wants to store session data at `/var/lib/php/sessions` which is read-only in Cloudron. To fix this problem you can move this data to `/run/php/sessions` with these commands:

```docker
RUN rm -rf /var/lib/php/sessions && ln -s /run/php/sessions /var/lib/php/sessions
```

Don't forget to create this directory and it's ownership in the `start.sh`:

```sh
mkdir -p /run/php/sessions
chown www-data:www-data /run/php/sessions
```

#### Java

Java scales its memory usage dynamically according to the available system memory. Due to how Docker works, Java sees the hosts total memory instead of the memory limit of the app. To restrict Java to the apps memory limit it is necessary to add a special parameter to Java calls.

```sh
LIMIT=$(($(cat /sys/fs/cgroup/memory/memory.memsw.limit_in_bytes)/2**20))
export JAVA_OPTS="-XX:MaxRAM=${LIMIT}M"
java ${JAVA_OPTS} -jar ...
```

## App Store

### Requirements

The Cloudron App Store is a mechanism to share your app with others who use Cloudron. To ensure that
apps are maintained, secure and well supported, we enforce the following rules:

* The app packaging code will be relocated to the [Cloudron Git Repo](https://git.cloudron.io/cloudron/).

* Contributed apps must have browser tests. You can see the various [app repos](https://git.cloudron.io/cloudron/)
  to get an idea on how to write these tests. The Cloudron team can help you write the tests.

* You agree that the Cloudron team will take over the responsibility of progressing the app further.

* You must sign the [Cloudron CLA](https://cla.cloudron.io/).

* The code must be licensed under MIT License.

### Upload for Testing

Once your app is ready, you can upload it to the store for `beta testing` by
other Cloudron users. This can be done using:

```
  cloudron appstore upload
```

You should now be able to visit `/#/appstore/<appid>?version=<appversion>` on your
Cloudron to check if the icon, description and other details appear correctly.

Other Cloudron users can install your app on their Cloudron's using
`cloudron install --appstore-id <appid@version>`.

### Publishing

Once you are satisfied with the beta testing, you can submit it for review.

```
  cloudron appstore submit
```

The cloudron.io team will review the app and publish the app to the store.

### Versioning and Updates

To create an update for an app, simply bump up the [semver version](/developer/manifest/#version) field in
the manifest and publish a new version to the store.

The Cloudron chooses the next app version to update to based on the following algorithm:
* Choose the maximum `package` version matching the app's current `major`, `minor`, `patch` version.
* Failing the above, choose the next patch version matching the app's current `major` and `minor` version.
* Failing the above, choose the next minor version matching the app's current `major` version.
* Failing the above, choose the next major version

For example, let's assume the versions 1.1.3, 1.1.4, 1.1.4-1, 1.1.4-2, 1.1.5, 1.2.6, 1.3.0, 2.0.0 are published.

* If the app is running 1.1.3, then app will directly update to 1.1.4-2 (skipping 1.1.4 and 1.1.4-1)
* Once in 1.1.4-2, the app will update to 1.1.5
* Once in 1.1.5, the app will update to 1.2.6
* Once in 1.2.6, the app will update to 1.3.0
* Once in 1.3.0, the app will update to 2.0.0

Packages with a major version bump are not auto-updated. They require the Cloudron admin to click the
update button. The intention is that the packager can pass on some instructions about possible breakages
in the changelog.

!!! note "Package version"
    A semver with no package version is treated as package version 0. This means that 1.2.4 is semantically
    the same as 1.2.4-0.

### Failed updates

The Cloudron always makes a backup of the app before making an update. Should the
update fail, the user can restore to the backup (which will also restore the app's
code to the previous version).

## Cloudron Button

The [Cloudron Button](/developer/button/) allows anyone to install your application with the click of a button
on their Cloudron.

The button can be added to just about any website including the application's website
and README.md files in GitHub repositories.

## Next steps

Congratulations! You are now well equipped to build web applications for the Cloudron.

You can see some examples of how real apps are packaged here:

  * [Lets Chat](https://git.cloudron.io/cloudron/letschat-app)
  * [Haste bin](https://git.cloudron.io/cloudron/haste-app)
  * [Pasteboard](https://git.cloudron.io/cloudron/pasteboard-app)
