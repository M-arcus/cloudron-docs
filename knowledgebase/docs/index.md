# Welcome to Cloudron! 

## What is Cloudron?

Cloudron is a platform that makes it easy to install, manage and secure web apps on your server.

You can install Cloudron on your server (from say AWS, Digital Ocean etc), give it a domain
name and start installing apps. Behind the scenes, the Cloudron automates all the tasks around
installation like configuring databases, DNS setup and Certificate management.

Cloudron provides a centralized way to manage users and specify which apps they can access.

Cloudron has a backup solution that lets you backup and restore each app individually
(compared to server snapshots). With Cloudron backups, you can even migrate your Cloudron 
in it's entirety from one server provider to another.

## The Cloudron App Store

The [Cloudron App Store](https://cloudron.io/appstore.html) provides a mechanism for
distribution and continuous update of apps. A good analogy for this is the Apple App Store for iOS or
Google Play for Android. Anyone today can easily install apps on their phones and the apps are kept up-to-date.
Cloudron does the same but for servers. You can easily install apps and receive continuous updates for
the apps via the Cloudron App Store.

<br/>

<center>
<video width="640" height="360" controls>
  <source src="/videos/cloudron-app-install.mp4" type="video/mp4">
  Your browser does not support the video tag.
</video>
</center>

## Motivation

Say you want to run a web application like Wordpress, GitLab, Rocket.chat or even an email server.
The first step is to start reading up installation manuals and configuring the server. Web apps today
use multiple package managers, languages and frameworks making this process very tedious and complicated.

Once the software is installed, DNS and SSL certificates have to be setup. If the server hosts
multiple apps, one needs to make sure that apps do not interfere with each other, setup a
reverse proxy and configure the firewall.

Installation is just one hurdle though. The server and apps must be secured and backed up
properly. Upstream releases must be tracked and updates must be applied on time.

As you can see, self-hosting web applications is error prone and time consuming. 1-click installers
and docker files automate some of the above tasks but requires one to have the technical know how to
complete the installation and put in the effort to keep it up-to-date.

We, at Cloudron, want to fix just that!

