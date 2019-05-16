# Apps

## Installing an app

Apps can be installed from the `App Store` menu item. Clicking on an app will display
information about the app.

<center>
<img src="/documentation/img/app_info.png" class="shadow" width="500px">
</center>

<br/>

Clicking the `Install` button will show an install dialog:

<center>
<img src="/documentation/img/app_install.png" class="shadow" width="500px">
</center>

<br/>

The `Location` field is the subdomain into which the app will be installed. Use the drop down
selector on the right to choose the domain into which the app will by installed.
If the subdomain field is empty, the app will be installed in the bare/naked domain (i.e
at `smartserver.space` in the picture above).

!!! note "Location field can be multi-level"
    The `Location` field can be any level deep. For example, you can specify location as
    `blog.dev` to make the app available at `blog.dev.smartserver.space`.

## Configuring an app

Clicking on the pencil button will bring up the app's configure dialog:

<center>
<img src="/documentation/img/app_configure_button.png" class="shadow" width="250px">
</center>

The configure dialog can be used for:

* Relocating an app to another subdomain
* Make the app available from another domain
* Specify the groups that can access the app
* Set `X-Frame-Options` to make the app embeddable in another website
* Change the maximum amount of memory that the app can use
* Specify a `robots.txt` to control indexing by search engines (Google, Bing, DDG)
* Setting up redirections

!!! note "No data loss"
    Re-configuring an app is a non-destructive action. Existing app data will be retained.

## Moving an app to another domain

Changing the location field in the app's configure dialog will move the app to
another domain or subdomain:

<center>
<img src="/documentation/img/app-configure.png" class="shadow" width="500px">
</center>

!!! note "No data loss"
    Moving an app to a new location is a non-destructive action. Existing app data will
    be migrated to the new domain.

## Setting up redirections

Redirections can be setup from the `Advanced` section in the app's configure dialog:

<center>
<img src="/documentation/img/app-redirect.png" class="shadow" width="500px">
</center>

In the above example, anyone visiting `www.smartserver.space` will be automatically redirected
to the bare domain (using HTTP 302).

The redirection feature preserves any URI components like subpaths in the original request.

## Labels and Tags

`Label` is the text that is displayed for the app on the dashboard below the icon. `Tags` are a
mechanism to tag apps with labels. For example, you can mark specific apps with the customer name
and filter apps by customer name.

The label and tag of an app can be changed in the `Display` section of the app's configure dialog:

<center>
<img src="/documentation/img/app-labels-and-tags.png" class="shadow" width="500px">
</center>

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
<img src="/documentation/img/app-memory-slider.png" class="shadow" width="500px">
</center>

!!! note "Memory limit includes swap"
    The memory limit specified above is a combination of RAM and swap space to be allocated
    for the app. Cloudron allocates 50% of this value as RAM and 50% as swap.

## Restricting app access to specific users

Many apps in Cloudron are integrated with Cloudron's user management. For such
apps, one or more groups or users can be assigned to an app to restrict
login. For apps not integrated with Cloudron user management, see the section
on controlling the [visibility of app icon in dashboard](#visibility-of-app-icon-in-dashboard).

Note that Cloudron only handles authentication. Assigning roles to users is
done within the application itself. For example, changing a user to become a
`commenter` or `author` inside Wordpress has to be done within Wordpress.

<center>
<img src="/documentation/img/app-configure-group-acl.png" class="shadow" width="500px">
</center>

* `Allow all users from this Cloudron` - Any user in the Cloudron can access the app.
* `Only allow the following users and groups` - Only the users and groups can access the app.

## Visibility of app icon in dashboard

The Dashboard of a Cloudron user displays the apps that the user can access. For apps that
use Cloudron Single Sign-on, the dashboard only displays an app if the user
[has access to it](#restricting-app-access-to-specific-users).

For apps configured to not use the Cloudron Single Sign-on (for example, some public app like a
Forum or Chat), the apps are displayed (by default) on the dashboard of all users. Admins
can control if an app appears in a user's dashboard using the `Dashboard Visibility` option
in the app's configure UI.

<center>
<img src="/documentation/img/apps-dashboard-visibility.png" class="shadow" width="500px">
</center>


## Mail FROM address

For apps that can send and/or receive email, Cloudron automatically assigns an address of the
form `<location>.app`. To change this name, click on `Configure` in the app grid and edit the
mailbox name in the `Advanced` tab.

<center>
<img src="/documentation/img/apps-mailbox-name.png" class="shadow" width="500px">
</center>

!!! note "Mailbox is not automatically created"
    The app is simply configured to send mails with the above name. If you want to receive
    email with the address, be sure to [create a mailbox](/documentation/email/#creating-mailboxes)
    or assign it as an [alias](/documentation/email/#creating-mail-aliases) for an existing mailbox.
    If a mailbox with the name does not exist, any replies to the email will bounce.

## Indexing by search engines (robots.txt)

The `Robots.txt` file is a file served from the root of a website to indicate which parts must be indexed by a search
engine. The file follows the [Robots Exclusion Standard](https://en.wikipedia.org/wiki/Robots_exclusion_standard).
Google has an [excellent document](https://developers.google.com/search/reference/robots_txt) about the semantics.

The robots.txt contents of an app can be set in the `Advanced settings` of the app's configure dialog.

By default, Cloudron does not setup a robots.txt for apps. When unset, the app is free to provide it's own robots.txt.

<center>
<img src="/documentation/img/app-robots-txt.png" class="shadow" width="500px">
</center>

In addition, the Cloudron admin page has a hardcoded robots.txt that disables indexing:
```
User-agent: *
Disallow: /
```

## Web terminal

Cloudron provides a web terminal that gives access to the app's file system. The web terminal
can be used to:

* Introspect and modify the app's files
* Access and modify the app's database (mysql, postgres, mongodb, redis)
* Modify the app's data directory
* Upload files to the /tmp directory. You can then work on this file from the terminal.
* Download files and directories (as tar.gz) from the app.
* Install plugins
* Repair an app if a plugin installation failed or database needs some modification

Note that Cloudron runs apps as containers with a read-only file system. Only `/run` (dynamic data),
`/app/data` (backup data) and `/tmp` (temporary files) are writable at runtime.

The web terminal can be accessed by clicking the 'Terminal' icon.

<center>
<img src="/documentation/img/app-grid-icons.png" class="shadow" width="300px">
</center>

Clicking the icon will pop up a new window. The terminal is essentially a shell into the app's file system.

<center>
<img src="/documentation/img/terminal-exec2.png" class="shadow" width="500px">
</center>

## FTP access

Certain apps like Wordpress, LAMP, Surfer support access to their data via SFTP. Files can be viewed
and uploaded using any SFTP client. The FTP connection information is displayed in the information
dialog (click the `i` button in the app grid).

<center>
<img src="/documentation/img/app-sftp-info.png" class="shadow" width="500px">
</center>

A SFTP client like [FileZilla](https://filezilla-project.org/) can be used to connect as follows:

* `Host` - `sftp://my.cloudron.ml`
* `Username` - `girish@blog2.cloudron.ml`
* `Password` - Cloudron password
* `Port` - 222

<center>
<img src="/documentation/img/sftp-filezilla.png" class="shadow" width="500px">
</center>

!!! note "Port 222"
    SFTP service runs at port 222. The server firewall already has this port open. However, you will
    have to whitelist this port in the Cloud firewall (e.g EC2 Security Group or DigitalOcean Firewall).

## Log viewer

To view the logs of an app, click the logs button on the app grid:

<center>
<img src="/documentation/img/app-grid-icons-logs.png" class="shadow" width="300px">
</center>

This will open up a popup dialog that display the logs:

<center>
<img src="/documentation/img/app-logs.png" class="shadow" width="500px">
</center>

## Embedding Apps

Cloudron apps can be embedded into other websites by setting `X-Frame-Options`. By default, this HTTP header is set to
`SAMEORIGIN` to prevent [Clickjacking](https://cloudron.io/blog/2016-07-15-site-embedding.html).

To allow embedding, enter the embedder website name in the `Advanced settings` of the app's configure dialog.

For example, to embed the live chat application hosted on `chat.example.com` into `www.example.com`, enter the value
`https://www.example.com` in the `chat` app's configure dialog.

`ALLOW-FROM` is [not supported](https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/X-Frame-Options#Browser_compatibility)
in Chrome. You can safely ignore the `Invalid 'X-Frame-Options' header encountered` message in the browser console.

<center>
<img src="/documentation/img/app-embed-url.png" class="shadow" width="500px">
</center>

## Uninstall an app

An app can be uninstalled clicking the `Uninstall` button.

<center>
<img src="/documentation/img/app_uninstall_button.png" class="shadow">
</center>

Uninstalling an app immediately removes all data associated with the app from the Cloudron.

!!! note "Backups are not removed"
    App backups are not removed when it is uninstalled and are only cleaned up based on the backup
    policy. Apps can always be [re-instated](/documentation/backups/#restoring-an-app-from-existing-backup)
    from their backups using the CLI tool.

## Staging environment

When doing website development, it is useful to have production and staging environments. Cloudron's
backup and clone features can be used to create a workflow as follows:

* Install the app in `staging.example.com`. Do edits and development as desired.
* Once ready, make a 'snapshot' of the app by making an [app backup](/documentation/backups/#making-an-app-backup)
* Use the [clone UI](/documentation/backups/#cloning-a-cloudron-app-in-same-cloudron) to install the app
  into `prod.example.com`.

The same mechanism above can be used bring latest production data to staging.

## Graphs

The Graphs view shows an overview of the disk and memory usage on your Cloudron.

<img src="/documentation/img/graphs.png" class="shadow">

The `Disk Usage` graph shows you how much disk space you have left. Note that the Cloudron will
send the Cloudron admins an email notification when the disk is ~90% full.

The `Apps` Memory graph shows the memory consumed by each installed app. You can click on each segment
on the graph to see the memory consumption over time in the chart below it.

The `System` Memory graph shows the overall memory consumption on the entire Cloudron. If you see
the Free memory < 50MB frequently, you should consider upgrading to a Cloudron with more memory.

## Installing Docker images or other non-Cloudron apps

Cloudron's approach to self-hosting means that it takes complete ownership of the server and only
tracks changes that are made via the web interface. For this reason, Cloudron does not support
installing apps via Docker or `apt` or `snap`. Any external changes made to the server (i.e other
than via the Cloudron web interface or API) may be lost across updates and at worst, might confuse
the Cloudron update mechanism putting your server at risk.

The best way to workaround this is to [package](../developer/packaging/) the apps as
Cloudron apps. Apps that have a Dockerfile can be trivially packaged for the Cloudron.

