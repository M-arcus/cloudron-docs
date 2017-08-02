# Apps

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

## Specifying another domain for an app

Cloudron installs apps as subdomains of the domain provided during setup time.
It is also possible to specify an entirely different domain for an app. An external
domain is set in the app's configure dialog and entering the domain in the location
dropdown.

<img src="/img/app-external-domain-ip.png" class="shadow">

This dialog will suggest adding a CNAME record (for subdomains) or an A record (for
naked domains). Once you setup a record with your DNS provider, the app will be accessible
from that external domain. Cloudron will automatically get an Lets Encrypt certificate
for the external domain. 

**NOTE:** You can set the external domain only after installing the app in a subdomain.
(For the curious, this is done so that we can 'reserve' a DNS record to CNAME to).

## Redirecting www domain

To redirect the bare domain to `www` (or `www` to the bare domain), we recommend installing
the `Surfer` app and setting up a HTML page that redirects.

For example, to redirect `www` to the bare domain:

* Install [Surfer](https://cloudron.io/store/io.cloudron.surfer.html) on the `www` subdomain.

* Login to surfer (`https://www.<domain>/_admin`) using your Cloudron credentials and upload the
  following HTML to redirect as `index.html`:

```
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>www.girish.in</title>
    <meta http-equiv="refresh" content="0;URL='https://girish.in/'" />
  </head>
</html>
```

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


