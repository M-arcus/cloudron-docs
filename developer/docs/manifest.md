# Manifest

## Overview

Every Cloudron Application contains a `CloudronManifest.json`.

The manifest contains two categories of information:

* Information about displaying the app on the Cloudron App Store. For example,
  the title, author information, description etc

* Information for installing the app on the Cloudron. This includes fields
  like httpPort, tcpPorts, udpPorts.

A CloudronManifest.json can **only** contain fields that are listed as part of this
specification. The Cloudron App Store and the Cloudron *may* reject applications that have
extra fields.

Here is an example manifest:

```
{
  "id": "com.example.test",
  "title": "Example Application",
  "author": "Girish Ramakrishnan <girish@cloudron.io>",
  "description": "This is an example app",
  "tagline": "A great beginning",
  "version": "0.0.1",
  "healthCheckPath": "/",
  "httpPort": 8000,
  "addons": {
    "localstorage": {}
  },
  "manifestVersion": 2,
  "website": "https://www.example.com",
  "contactEmail": "support@clourdon.io",
  "icon": "file://icon.png",
  "tags": [ "test", "collaboration" ],
  "mediaLinks": [ "https://images.rapgenius.com/fd0175ef780e2feefb30055be9f2e022.520x343x1.jpg" ]
}
```

## Fields

### addons

Type: object

Required: no

Allowed keys

* [email](/addons/#email)
* [ldap](/addons/#ldap)
* [localstorage](/addons/#localstorage)
* [mongodb](/addons/#mongodb)
* [mysql](/addons/#mysql)
* [oauth](/addons/#oauth)
* [postgresql](/addons/#postgresql)
* [recvmail](/addons/#recvmail)
* [redis](/addons/#redis)
* [sendmail](/addons/#sendmail)

The `addons` object lists all the [addons](/addons/) and the addon configuration used by the application.

Example:
```
  "addons": {
    "localstorage": {},
    "mongodb": {}
  }
```

### author

Type: string

Required: yes

The `author` field contains the name and email of the app developer (or company).

Example:
```
  "author": "Cloudron UG <girish@cloudron.io>"
```

### capabilities

Type: array of strings

Required: no

The `capabilities` field can be used to request extra [capabilities](https://docs.docker.com/engine/reference/run/#runtime-privilege-and-linux-capabilities).

By default, Cloudron apps are unprivileged and cannot perform many operations including
changing network configuration, launch docker containers etc.

Currently, the only permitted value is [`net_admin`](http://man7.org/linux/man-pages/man7/capabilities.7.html).
This capability can be used to perform various network related operations like:

* interface configuration;
* administration of IP firewall, masquerading, and accounting;
* modify routing tables;

Example:
```
  "capabilities": [
    "net_admin"
  ]
```

### changelog

Type: markdown string

Required: no (required for submitting to the Cloudron App Store)

The `changelog` field contains the changes in this version of the application. This string
can be a markdown style bulleted list.

Example:
```
  "changelog": "* Add support for IE8 \n* New logo"
```

### contactEmail

Type: email

Required: yes

The `contactEmail` field contains the email address that Cloudron users can contact for any
bug reports and suggestions.

Example:
```
  "contactEmail": "support@testapp.com"
```

### description

Type: markdown string

Required: yes

The `description` field contains a detailed description of the app. This information is shown
to the user when they install the app from the Cloudron App Store.

Example:
```
  "description": "This is a detailed description of this app."
```

A large `description` can be unweildy to manage and edit inside the CloudronManifest.json. For
this reason, the `description` can also contain a file reference. The Cloudron CLI tool fills up
the description from this file when publishing your application.

Example:
```
  "description:": "file://DESCRIPTION.md"
```

### documentationUrl

Type: url

Required: yes

The `documentationUrl` field is a URL where the user can read docs about the application.

Example:
```
  "website": "https://example.com/myapp/docs"
```

### healthCheckPath

Type: url path

Required: yes

The `healthCheckPath` field is used by the Cloudron Runtime to determine if your app is running and
responsive. The app must return a 2xx HTTP status code as a response when this path is queried. In
most cases, the default "/" will suffice but there might be cases where periodically querying "/"
is an expensive operation. In addition, the app might want to use a specialized route should it
want to perform some specialized internal checks.

Example:
```
  "healthCheckPath": "/"
```
### httpPort

Type: positive integer

Required: yes

The `httpPort` field contains the TCP port on which your app is listening for HTTP requests. This
is the HTTP port the Cloudron will use to access your app internally.

While not required, it is good practice to mark this port as `EXPOSE` in the Dockerfile.

Cloudron Apps are containerized and thus two applications can listen on the same port. In reality,
they are in different network namespaces and do not conflict with each other.

Note that this port has to be HTTP and not HTTPS or any other non-HTTP protocol. HTTPS proxying is
handled by the Cloudron platform (since it owns the certificates).

Example:
```
  "httpPort": 8080
```

### icon

Type: local image filename

Required: no (required for submitting to the Cloudron App Store)

The `icon` field is used to display the application icon/logo in the Cloudron App Store. Icons are expected
to be square of size 256x256.

```
  "icon": "file://icon.png"
```

### id

Type: reverse domain string

Required: yes

The `id` is a unique human friendly Cloudron App Store id. This is similar to reverse domain string names used
as java package names. The convention is to base the `id` based on a domain that you own.

The Cloudron tooling allows you to build applications with any `id`. However, you will be unable to publish
the application if the id is already in use by another application.

```
  "id": "io.cloudron.testapp"
```

### manifestVersion

Type: integer

Required: yes

`manifestVersion` specifies the version of the manifest and is always set to 2.

```
  "manifestVersion": 2
```

### mediaLinks

Type: array of urls

Required: no (required for submitting to the Cloudron App Store)

The `mediaLinks` field contains an array of links that the Cloudron App Store uses to display a slide show of pictures of the application.

They have to be publicly reachable via `https` and should have an aspect ratio of 3 to 1.
For example `600px by 200px` (with/height).

```
  "mediaLinks": [
    "https://s3.amazonaws.com/cloudron-app-screenshots/org.owncloud.cloudronapp/556f6a1d82d5e27a7c4fca427ebe6386d373304f/2.jpg",
    "https://images.rapgenius.com/fd0175ef780e2feefb30055be9f2e022.520x343x1.jpg"
  ]
```

### memoryLimit

Type: bytes (integer)

Required: no

The `memoryLimit` field is the maximum amount of memory (including swap) in bytes an app is allowed to consume before it
gets killed and restarted.

By default, all apps have a memoryLimit of 256MB. For example, to have a limit of 500MB,

```
  "memoryLimit": 524288000
```

### maxBoxVersion

Type: semver string

Required: no

The `maxBoxVersion` field is the maximum box version that the app can possibly run on. Attempting to install the app on
a box greater than `maxBoxVersion` will fail.

This is useful when a new box release introduces features which are incompatible with the app. This situation is quite
unlikely and it is recommended to leave this unset.

### minBoxVersion

Type: semver string

Required: no

The `minBoxVersion` field is the minimum box version that the app can possibly run on. Attempting to install the app on
a box lesser than `minBoxVersion` will fail.

This is useful when the app relies on features that are only available from a certain version of the box. If unset, the
default value is `0.0.1`.

### postInstallMessage

Type: markdown string

Required: no

The `postInstallMessageField` is a message that is displayed to the user after an app is installed.

The intended use of this field is to display some post installation steps that the user has to carry out to
complete the installation. For example, displaying the default admin credentials and informing the user to
to change it.

The message can have the following special tags:
* `<sso> ... </sso>` - Content in `sso` blocks are shown if SSO enabled.
* `<nosso> ... </nosso>`- Content in `nosso` blocks are shows when SSO is disabled.

### optionalSso

Type: boolean

Required: no

The `optionalSso` field can be set to true for apps that can be installed optionally without using the Cloudron user management.

This only applies if any Cloudron auth related addons are used. When set, the Cloudron will not inject the auth related addon environment variables.
Any app startup scripts have to be able to deal with missing env variables in this case.

### tagline

Type: one-line string

Required: no (required for submitting to the Cloudron App Store)

The `tagline` is used by the Cloudron App Store to display a single line short description of the application.

```
  "tagline": "The very best note keeper"
```

### tags

Type: Array of strings

Required: no (required for submitting to the Cloudron App Store)

The `tags` are used by the Cloudron App Store for filtering searches by keyword.

```
  "tags": [ "git", "version control", "scm" ]
```

Available tags:
  * blog
  * chat
  * git
  * email
  * sync
  * gallery
  * notes
  * project
  * hosting
  * wiki

### targetBoxVersion

Type: semver string

Required: no

The `targetBoxVersion` field is the box version that the app was tested on. By definition, this version has to be greater
than the `minBoxVersion`.

The box uses this value to enable compatibility behavior of APIs. For example, an app sets the targetBoxVersion to 0.0.5
and is published on the store. Later, box version 0.0.10 introduces a new feature that conflicts with how apps used
to run in 0.0.5 (say SELinux was enabled for apps). When the box runs such an app, it ensures compatible behavior
and will disable the SELinux feature for the app.

If unspecified, this value defaults to `minBoxVersion`.

### tcpPorts

Type: object

Required: no

Syntax: Each key is the environment variable. Each value is an object containing `title`, `description` and `defaultValue`.
An optional `containerPort` may be specified.

The `tcpPorts` field provides information on the non-http TCP ports/services that your application is listening on. During
installation, the user can decide how these ports are exposed from their Cloudron.

For example, if the application runs an SSH server at port 29418, this information is listed here. At installation time,
the user can decide any of the following:
* Expose the port with the suggested `defaultValue` to the outside world. This will only work if no other app is being exposed at same port.
* Provide an alternate value on which the port is to be exposed to outside world.
* Disable the port/service.

To illustrate, the application lists the ports as below:
```
  "tcpPorts": {
    "SSH_PORT": {
      "title": "SSH Port",
      "description": "SSH Port over which repos can be pushed & pulled",
      "defaultValue": 29418,
      "containerPort": 22
    }
  },
```

In the above example:
* `SSH_PORT` is an app specific environment variable. Only strings, numbers and _ (underscore) are allowed. The author has to ensure that they don't clash with platform profided variable names.

* `title` is a short one line information about this port/service.

* `description` is a multi line description about this port/service.

* `defaultValue` is the recommended port value to be shown in the app installation UI.

* `containerPort` is the port that the app is listening on (recall that each app has it's own networking namespace).

In more detail:

* If the user decides to disable the SSH service, this environment variable `SSH_PORT` is absent. Applications _must_ detect this on
  start up and disable these services.

* `SSH_PORT` is set to the value of the exposed port. Should the user choose to expose the SSH server on port 6000, then the
  value of SSH_PORT is 6000.

* `defaultValue` is **only** used for display purposes in the app installation UI.  This value is independent of the value
   that the app is listening on. For example, the app can run an SSH server at port 22 but still recommend a value of 29418 to the user.

* `containerPort` is the port that the app is listening on. The Cloudron runtime will _bridge_ the user chosen external port
  with the app specific `containerPort`. Cloudron Apps are containerized and each app has it's own networking namespace.
  As a result, different apps can have the same `containerPort` value because these values are namespaced.

* The environment variable `SSH_PORT` may be used by the app to display external URLs. For example, the app might want to display
  the SSH URL. In such a case, it would be incorrect to use the `containerPort` 22 or the `defaultValue` 29418 since this is not
  the value chosen by the user.

* `containerPort` is optional and can be omitted, in which case the bridged port numbers are the same internally and externally.
  Some apps use the same variable (in their code) for listen port and user visible display strings. When packaging these apps,
  it might be simpler to listen on `SSH_PORT` internally. In such cases, the app can omit the `containerPort` value and should
  instead reconfigure itself to listen internally on `SSH_PORT` on each start up.

### title

Type: string

Required: yes

The `title` is the primary application title displayed on the Cloudron App Store.

Example:
```
  "title": "Gitlab"
```

### udpPorts

Type: object

Required: no

Syntax: Each key is the environment variable. Each value is an object containing `title`, `description` and `defaultValue`.
An optional `containerPort` may be specified.

The `udpPorts` field provides information on the non-http TCP ports/services that your application is listening on. During
installation, the user can decide how these ports are exposed from their Cloudron.

For example, if the application runs an SSH server at port 29418, this information is listed here. At installation time,
the user can decide any of the following:
* Expose the port with the suggested `defaultValue` to the outside world. This will only work if no other app is being exposed at same port.
* Provide an alternate value on which the port is to be exposed to outside world.
* Disable the port/service.

To illustrate, the application lists the ports as below:
```
  "udpPorts": {
    "VPN_PORT": {
      "title": "VPN Port",
      "description": "Port over which OpenVPN server listens",
      "defaultValue": 11194,
      "containerPort": 1194
    }
  },
```

In the above example:
* `VPN_PORT` is an app specific environment variable. Only strings, numbers and _ (underscore) are allowed. The author has to ensure that they don't clash with platform profided variable names.

* `title` is a short one line information about this port/service.

* `description` is a multi line description about this port/service.

* `defaultValue` is the recommended port value to be shown in the app installation UI.

* `containerPort` is the port that the app is listening on (recall that each app has it's own networking namespace).

### version

Type: semver string

Required: yes

The `version` field specifies a [semver](http://semver.org/) string. The version is used by the Cloudron to compare versions and to
determine if an update is available.

Example:
```
  "version": "1.1.0"
```

### website

Type: url

Required: yes

The `website` field is a URL where the user can read more about the application.

Example:
```
  "website": "https://example.com/myapp"
```
