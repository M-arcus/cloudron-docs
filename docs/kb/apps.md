# Apps

## Installing an app

You can install apps on the Cloudron by choosing the `App Store` menu item. Use the 'Search' bar
to search for apps.

Clicking on app gives you information about the app.

<img src="/img/app_info.png" class="shadow">

Clicking the `Install` button will show an install dialog like below:

<img src="/img/app_install.png" class="shadow">

The `Location` field is the subdomain in which your app will be installed. For example, if you use the
`mail` location for your web mail client, then it will be accessible at `mail.<domain>`.

Tip: You can access the apps directly on your browser using `mail.<domain>`. You don't have to
visit the Cloudron administration panel.

## Moving an application to another subdomain

Click on the wrench button will bring up the configure dialog.

<img src="/img/app_configure_button.png" class="shadow">

<img src="/img/app_configure.png" class="shadow">

Changing an app's configuration has a small downtime (usually about a minute).

## Restoring an app from existing backup

Apps can be restored to a previous backup by clicking on the `Restore` button.

<img src="/img/app_restore_button.png" class="shadow">

Note that restoring previous data might also restore the previous version of the software. For example, you might
be currently using Version 5 of the app. If you restore to a backup that was made with Version 3 of the app, then the restore
operation will install Version 3 of the app. This is because the latest version may not be able to handle old data.

## Uninstall an app

You can uninstall an app by clicking the `Uninstall` button.

<img src="/img/app_uninstall_button.png" class="shadow">

Note that all data associated with the app will be immediately removed from the Cloudron. App data might still
persist in your old backups and the [CLI tool](https://git.cloudron.io/cloudron/cloudron-cli) provides a way to
restore from those old backups should it be required.

## Increasing the memory limit of an app

All Cloudron apps are run with a memory limit. This ensures that no app
can bring down the whole Cloudron. The default memory limit of an app
is set by the app author at packaging time. This limit is usually the
minimum amount of memory required for the app. Cloudron admins are expected
to tweak the memory limit of an app based on their usage.

When an app runs out of memory, Cloudron automatically restarts it and
sends an OOM email notification to Cloudron admins.

The memory limit can be set by adjusting the slider in the Configure dialog's
`Advanced Setting` section.

<img src="/img/app-memory-slider.png" class="shadow">

## Restricting app access to specific users

Most apps in Cloudron are integrated with Cloudron's Single Sign-On. For such
apps, you can assign one or more groups to an app and the Cloudron will restrict
login to only the users in those groups.

Note that Cloudron only handles authentication. Assigning roles to users is
done within the application itself (for example, to change a user to become a
`commenter` or `author` or some other app specific role).

<img src="/img/configure-group-acl.png" class="shadow">

* `Every Cloudron user` - Any user in your Cloudron can access the app. Initially, you are the only
   user in your Cloudron. Unless you explicitly invite others, nobody else can access these apps.
   Note that the term 'access' depends on the app. For a blog, this means that nobody can post new
   blog posts (but anybody can view them). For a chat server, this might mean that nobody can access
   your chat server.

* `Restrict to groups` - Only users in the groups can access the app.

## Specifying an external domain for an app

Cloudron installs apps as subdomains of the domain provided during setup time.
It is also possible to specify an entirely different domain for an app. An external
domain is set in the app's configure dialog by choosing `External Domain` in the 
location dropdown.

<img src="/img/app-external-domain-ip.png" class="shadow">

This dialog will suggest adding a CNAME record (for subdomains) or an A record (for
naked domains). Once you setup a record with your DNS provider, the app will be accessible
from that external domain. Cloudron will automatically get an Lets Encrypt certificate
for the external domain.

**NOTE:** You can set the external domain only after installing the app in a subdomain.
(For the curious, this is done so that we can 'reserve' a DNS record to CNAME to).

## Redirecting www domain

To redirect the bare domain to `www` (or `www` to the bare domain), we recommend installing
the `LAMP` app and setting up a ``.htaccess` file based redirect.

For example, to redirect `www` to the bare domain:

* Install [LAMP](https://cloudron.io/store/lamp.cloudronapp.html) on the `www` subdomain.

* Use the [CLI tool](https://git.cloudron.io/cloudron/cloudron-cli) to get remote access into the app and create a `.htaccess` file:
```
cloudron exec --app www
$ echo "redirect 301 / https://domain.com/" > /app/data/public/.htaccess
```

This also preserves any URI components like subpaths in the original request.

## Indexing by search engines (robots.txt)

The `Robots.txt` file is a file served from the root of a website to indicate which parts must be indexed by a search
engine. The file follows the [Robots Exclusion Standard](https://en.wikipedia.org/wiki/Robots_exclusion_standard).
Google has an [excellent document](https://developers.google.com/search/reference/robots_txt) about the semantics.

You can set the robots.txt contents of an app in the Advanced settings of the app's configure dialog.

By default, Cloudron does not setup a robots.txt for apps. The app is free to provide it's own robots.txt. A custom
robots.txt can be setup from the app's configure dialog.

<img src="/img/robots-txt.png" class="shadow">

In addition, the Cloudron admin page has a hardcoded robots.txt that disables indexing:
```
User-agent: *
Disallow: /
```

## Graphs

The Graphs view shows an overview of the disk and memory usage on your Cloudron.

<img src="/img/graphs.png" class="shadow">

The `Disk Usage` graph shows you how much disk space you have left. Note that the Cloudron will
send the Cloudron admins an email notification when the disk is ~90% full.

The `Apps` Memory graph shows the memory consumed by each installed app. You can click on each segment
on the graph to see the memory consumption over time in the chart below it.

The `System` Memory graph shows the overall memory consumption on the entire Cloudron. If you see
the Free memory < 50MB frequently, you should consider upgrading to a Cloudron with more memory.

## Embedding Apps

It is possible to embed Cloudron apps into other websites. By default, this is disabled to prevent
[Clickjacking](https://cloudron.io/blog/2016-07-15-site-embedding.html).

You can set a website that is allowed to embed your Cloudron app using the app's [Configure dialog](#configuration).
Click on 'Show Advanced Settings...' and enter the embedder website name.
