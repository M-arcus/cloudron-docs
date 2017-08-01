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

