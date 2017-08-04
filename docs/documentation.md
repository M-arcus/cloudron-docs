# Welcome to Cloudron! 

## What is Cloudron?

The Cloudron is the best platform self-hosting web applications on your server. You
can easily install apps on it, add users, manage access restriction and keep your
server and apps updated with no effort.

You might wonder that there are so many 1-click app solutions out there and what is so special
about Cloudron? As the name implies, 1-click installers simply install code into a server
and leave it at that. There's so much more to do:

1. Configure a domain to point to your server
2. Setup SSL certificates and renew them periodically
3. Ensure apps are backed up correctly
4. Ensure apps are uptodate and secure
5. Have a mechanism to quickly restore apps from a backup
6. Manage users across all your apps
7. Get alerts and notifications about the status of apps

... and so on ...

We made the Cloudron to dramatically lower the bar for people to run apps on servers. Just provide
a domain name, install apps and add users. All the server management tasks listed above is
completely automated.

If you want to learn more about the secret sauce that makes the Cloudron, please read our
[architecture overview](/references/architecture.html).

## Use cases

Here are some of the apps you can run on a Cloudron:

* RSS Reader
* Chat, IRC, Jabber servers
* Public forum
* Blog
* File syncing and sharing
* Code hosting
* Email

Our list of apps is growing everyday, so be sure to [follow us on twitter](https://twitter.com/cloudron_io).

## Understand

Before installing the Cloudron, it is helpful to understand Cloudron's design. The Cloudron
intends to make self-hosting effortless. It takes care of updates, backups, firewall, dns setup,
certificate management etc. All app and user configuration is carried out using the web interface.

This approach to self-hosting means that the Cloudron takes complete ownership of the server and
only tracks changes that were made via the web interface. Any external changes made to the server
(i.e other than via the Cloudron web interface or API) may be lost across updates.

The Cloudron requires a domain name when it is installed. Apps are installed into subdomains.
The `my` subdomain is special and is the location of the Cloudron web interface. For this to
work, the Cloudron requires a way to programmatically configure the DNS entries of the domain.
Note that the Cloudron will never overwrite _existing_ DNS entries and refuse to install
apps on existing subdomains (so, it is safe to reuse an existing domain that runs other services).

## Shortcuts

<div class="shortcuts">
<a href="https://git.cloudron.io/cloudron/box/issues" target="_blank">
    <br/><i class="fa fa-bug fa-3x"></i><br/>
    Report an Issue
</a><a href="https://chat.cloudron.io" target="_blank">
    <br/><i class="fa fa-terminal fa-3x"></i><br/>
    Chat
</a><a href="/installation/">
    <br/><i class="fa fa-file-text-o fa-3x"></i><br/>
    Install
</a>
</div>
