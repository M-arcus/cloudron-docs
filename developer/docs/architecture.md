# Architecture

## Introduction

The Cloudron platform is designed to easily install and run web applications.
The application architecture is designed to let the Cloudron take care of system
operations like updates, backups, firewalls, domain management, certificate management
etc. This allows app developers to focus on their application logic instead of deployment.

At a high level, an application provides an `image` and a `manifest`. The image is simply
a docker image that is a bundle of the application code and it's dependencies.  The manifest
file specifies application runtime requirements like database type and authentication scheme.
It also provides meta information for display purposes in the [Cloudron App Store](/appstore.html)
like the title, icon and pricing.

## Image

Application images are created using [Docker](https://www.docker.io). Docker provides a way
to package (and containerize) the application as a filesystem which contains it's code, system libraries
and just about anything the app requires. This flexible approach allows the application to use just
about any language or framework.

Application images are instantiated as `containers`. Cloudron can run one or more isolated instances
of the same application as one or more containers.

Containerizing your application provides the following benefits:

* Apps run in the familiar environment that they were packaged for and can have libraries
and packages that are independent of the host OS.
* Containers isolate applications from one another.

The [base image](/baseimage) is the parent of all app images.

## Cloudron Manifest

Each app provides a `CloudronManifest.json` that specifies information required for the
`Cloudron App Store` and for the installation of the image in the Cloudron.

Information required for container installation includes:

* List of `addons` like databases, caches, authentication mechanisms and file systems
* The http port on which the container is listening for incoming requests
* Additional TCP ports on which the application is listening to (for e.g., git, ssh,
irc protocols)

Information required for the Cloudron App Store includes:

* Unique App Id
* Title
* Version
* Logo

See the [manifest reference](/manifest) for more information.

## Addons

Addons are services like database, authentication, email, caching that are part of the
Cloudron. Setup, provisioning, scaling and maintenance of addons is taken care of by the
Cloudron.

The fundamental idea behind addons is to allow resource sharing across applications.
For example, a single MySQL server instance can be used across multiple apps. The Cloudron
sets up addons in such a way that apps are isolated from each other.

Addons are opt-in and must be specified in the Cloudron Manifest. When the app runs, environment
variables contain the necessary information to access the addon. See the
[addon reference](/addons) for more information.

## Authentication

The Cloudron provides a centralized dashboard to manage users, roles and permissions. Applications
do not create or manage user credentials on their own and instead use one of the various
authentication strategies provided by the Cloudron.

Authentication strategies include [OAuth 2.0](/addons/#oauth)
or [LDAP](/addons/#ldap).

Authorizing users is application specific and it is only authentication that is delegated to the
Cloudron.

## Platform Diagram

<center>
<img src="/blog/img/cloudron-architecture.svg" width="80%">
</center>


## Cloudron App Store

The Cloudron App Store provides a mechanism for distribution and continuous update of apps. A good analogy
for this is the Apple App Store on iOS or Google Play on Android. App developers can publish apps to the
Cloudron App Store and deliver continous updates for their apps.

