# Certificates

## Lets Encrypt integration

Cloudron integrates with [Let's Encrypt](http://letsencrypt.org/) to install
TLS certificates for apps automatically. It also renews certificates automatically.

Cloudron utilizes the `http-01` scheme to validate the domain with Lets Encrypt (this
scheme involves provisioning an HTTP resource under a well-known URI).

## Automatic renewal of Let's Encrypt certificates

Cloudron attempts to start renewing certificates automatically about 1 month before expiry of the
certificate. If it fails to renew, it will send a notification email to the Cloudron administrators.
If the Cloudron admin does not take any action (after getting reminded 30 times), Cloudron will start
using fallback certificates for the app.

## Revokation of Let's Encrypt Certificate

Cloudron does not revoke certificates when an app is installed. Instead it keeps the
certificate, so that it can simply be reused if another app is installed in the same
subdomain. This allows you to install apps for testing in the same location, say 'test',
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
to install or renew Let's Encrypt certificate. The fallback certificates can be set in the
`Domains & Certs` settings page. Note that this certificate must be a wildcard certificate
for the domain.

## Setting custom per-application certificates

It is possible to set a custom certificate for each installed application. This can be achieved
by using the [REST API](/references/api/#configure-app).

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

