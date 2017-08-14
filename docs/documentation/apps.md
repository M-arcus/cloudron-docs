# Apps

## Installing an app

Apps can be installed from the `App Store` menu item. Clicking on an app will display
information about the app.

<center>
<img src="/img/app_info.png" class="shadow" width="600px">
</center>

<br/>

Clicking the `Install` button will show an install dialog:

<center>
<img src="/img/app_install.png" class="shadow" width="600px">
</center>

<br/>

The `Location` field is the subdomain into which the app will be installed. For example, if you use the
`chat` location for Rocket.Chat, then it will be installed at `chat.domain.com`. If the subdomain field
is empty, the app will be installed at `domain.com`.

## Re-configuring an app

Click on the pencil button will bring up the configure dialog:

<center>
<img src="/img/app_configure_button.png" class="shadow">
</center>

<br/>

The configure dialog can be used for:

* Relocating an app to another subdomain
* Make the app available from another domain
* Specify the groups that can access the app
* Set `X-Frame-Options` to make the app embeddable in another website
* Change the maximum amount of memory that the app can use
* Specify a `robots.txt` to control indexing by search engines (Google, Bing, DDG)

## Moving an app to another subdomain

Changing the location field in the app's configure dialog will move the app to
another subdomain:

<center>
<img src="/img/app_configure.png" class="shadow">
</center>

## Specifying an external domain for an app

Cloudron installs apps as subdomains of the domain provided during setup time.
It is also possible to specify an entirely different domain for an app. An external
domain is set in the app's configure dialog by choosing `External Domain` in the 
location dropdown.

<center>
<img src="/img/app-external-domain-ip.png" class="shadow" width="600px">
</center>

This dialog will suggest adding a CNAME record (for subdomains) or an A record (for
naked domains). Once you setup a record with your DNS provider, the app will be accessible
from that external domain.

**NOTE:** An external domain can be set only _after_ installing the app.
For the curious, this is done so that we can 'reserve' a DNS subdomain record to CNAME to.

## Increasing the memory limit of an app

All apps are run with a memory limit to ensure that no app can bring down the whole
Cloudron. The default memory limit of an app is set by the app author at packaging
time. This limit is usually the minimum amount of memory required for the app.
Cloudron admins are expected to tweak the memory limit of an app based on their usage.

When an app runs out of memory, Cloudron automatically restarts it and sends an OOM
email notification to Cloudron admins.

The memory limit can be set by adjusting the slider in the Configure dialog's
`Advanced Setting` section.

<center>
<img src="/img/app-memory-slider.png" class="shadow">
</center>

## Restricting app access to specific users

Most apps in Cloudron are integrated with Cloudron's Single Sign-On. For such
apps, one or more groups can be assigned to an app and the Cloudron will restrict
login to only the users that are part of those groups.

Note that Cloudron only handles authentication. Assigning roles to users is
done within the application itself (for example, to change a user to become a
`commenter` or `author` or some other app specific role).

<center>
<img src="/img/app-configure-group-acl.png" class="shadow">
</center>

* `Every Cloudron user` - Any user in the Cloudron can access the app. 
* `Restrict to groups` - Only users in the groups can access the app.

## Indexing by search engines (robots.txt)

The `Robots.txt` file is a file served from the root of a website to indicate which parts must be indexed by a search
engine. The file follows the [Robots Exclusion Standard](https://en.wikipedia.org/wiki/Robots_exclusion_standard).
Google has an [excellent document](https://developers.google.com/search/reference/robots_txt) about the semantics.

The robots.txt contents of an app can be set in the `Advanced settings` of the app's configure dialog.

By default, Cloudron does not setup a robots.txt for apps. When unset, the app is free to provide it's own robots.txt.

<center>
<img src="/img/app-robots-txt.png" class="shadow">
</center>

In addition, the Cloudron admin page has a hardcoded robots.txt that disables indexing:
```
User-agent: *
Disallow: /
```

## Embedding Apps

Cloudron apps can be embedded into other websites by setting `X-Frame-Options`. By default, this HTTP header is set to
`SAMEORIGIN` to prevent [Clickjacking](https://cloudron.io/blog/2016-07-15-site-embedding.html).

To allow embedding, enter the embedder website name in the `Advanced settings` of the app's configure dialog.

For example, to embed the live chat application hosted on `chat.domain.com` into `www.domain.com`, enter the value
`https://www.domain.com` in the `chat` app's configure dialog.

`ALLOW-FROM` is [not supported](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options#Browser_compatibility)
in Chrome. You can safely ignore the `Invalid 'X-Frame-Options' header encountered` message in the browser console.

<center>
<img src="/img/app-embed-url.png" class="shadow">
</center>

## Uninstall an app

An app can be uninstalled clicking the `Uninstall` button.

<center>
<img src="/img/app_uninstall_button.png" class="shadow">
</center>

Uninstalling an app immediately removes all data associated with the app from the Cloudron.

Note that app backups are not removed when it is uninstalled and are only cleaned up
based on the backup policy.

## Redirecting www domain

To redirect the bare domain to `www` (or `www` to the bare domain), we recommend installing
the `LAMP` app and setting up a `.htaccess` file based redirect.

For example, to redirect `www` to the bare domain:

* Install [LAMP](https://cloudron.io/store/lamp.cloudronapp.html) on the `www` subdomain.

* Use the [CLI tool](/documentation/cli/) to get remote access into the app and create a `.htaccess` file:
```
cloudron exec --app www
$ echo "redirect 301 / https://domain.com/" > /app/data/public/.htaccess
```

This also preserves any URI components like subpaths in the original request.

## Graphs

The Graphs view shows an overview of the disk and memory usage on your Cloudron.

<img src="/img/graphs.png" class="shadow">

The `Disk Usage` graph shows you how much disk space you have left. Note that the Cloudron will
send the Cloudron admins an email notification when the disk is ~90% full.

The `Apps` Memory graph shows the memory consumed by each installed app. You can click on each segment
on the graph to see the memory consumption over time in the chart below it.

The `System` Memory graph shows the overall memory consumption on the entire Cloudron. If you see
the Free memory < 50MB frequently, you should consider upgrading to a Cloudron with more memory.

## Installing Docker images or other non-Cloudron apps

Cloudron's approach to self-hosting means that it takes complete ownership of the server and only
tracks changes that are made via the web interface. For this reason, Cloudron does not support
installing apps via Docker or apt-get or snap. Any external changes made to the server (i.e other
than via the Cloudron web interface or API) may be lost across updates and at worst, might confuse
the Cloudron update mechanism putting your server at risk.

The best way to workaround this is to [package](/documentation/developer/packaging/) the apps as
Cloudron apps. Apps that have a Dockerfile can be trivially packaged for the Cloudron.

