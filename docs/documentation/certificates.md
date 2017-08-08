# Certificates

## Lets Encrypt integration

Cloudron integrates with [Let's Encrypt](http://letsencrypt.org/) to install
TLS certificates for apps automatically. Certificates are renewed automatically.
A failure notification is sent to the Cloudron administrators if renewal fails.

Cloudron utilizes the `http-01` scheme to validate the domain with Lets Encrypt (this
scheme involves provisioning an HTTP resource under a well-known URI). For this reason,
the server's incoming port 80 must be kept open.

## Automatic renewal of Let's Encrypt certificates

Cloudron attempts to start renewing certificates automatically 1 month before expiry of the
certificate. If it fails to renew, it will send a notification email to the Cloudron administrators.
If the Cloudron admin does not take any action (after getting reminded 30 times), Cloudron will start
using fallback certificates for the app.

## Manually renewing Let's Encrypt certificate

Cloudron can sporadically fail to get Let's Encrypt certificates (for example, Let's Encrypt is down).
To manually trigger the renewal, open the app's configure dialog and `Save` without making any changes.

## Revokation of Let's Encrypt Certificate

Cloudron does not revoke certificates when an app is uninstalled. Instead, it retains the
certificate, so that it can be reused if another app is installed in the same
subdomain. This allows you to install apps for testing in the same location, say `test`,
and not have to worry about running over the Let's Encrypt rate limit.

## Limitations of Let's Encrypt

When using Let's Encrypt, please be aware of the following:

* There is a [rate limit](https://letsencrypt.org/docs/rate-limits/) of 20 certificates
  for a domain per week.

* Let's Encrypt participates in Certificate transparency. This means that your apps and
  subdomains are [discoverable](https://crt.sh/). Some [hackers](https://www.golem.de/news/certificate-transparency-hacking-web-applications-before-they-are-installed-1707-129172.html) take advantage of this to   hack web applications
  before they are in installed.

## Setting fallback wildcard certificates

Cloudron generates a self-signed certificates that it uses as the fallback should it fail
to install or renew Let's Encrypt certificate. The auto-generated fallback certificate
can be replaced with a custom wildcard certificate in the `Domains & Certs` page.

<br/>

<center>
<img src="/img/cert-fallback.png" class="shadow" width="600px">
</center>

## Setting custom per-application certificates

Custom certificates can be set for each installed application. This can be used to set an
Extended Validation (EV) certificate for an app.

This can be achieved by using the [REST API](/documentation/developer/api/#configure-app).

## Common reasons for Let's Encrypt Certificate failure

Here are some of the common reasons why the Cloudron might fail to get certificates via
Let's Encrypt.

* The Cloudron administrator email is not valid. Let's Encrypt requires a valid email id
  for issuing certificates. Please check the email id in the Account page.

* Let's Encrypt [rate limit](https://letsencrypt.org/docs/rate-limits/) was reached.

## CAA records for Lets Encrypt

Starting Sep 2017, Lets Encrypt will check for CAA records to validate if the domain owner
has authorized the CA to issue certificates for the domain. For this reason, make sure that
either the CAA record for the domain is [empty](https://community.letsencrypt.org/t/how-to-use-without-caa/38539/2)
OR setup a CAA record allowing `letsencrypt.org`.


