# Certificates

## Let's Encrypt integration

Cloudron integrates with [Let's Encrypt](http://letsencrypt.org/) to install
and renew TLS certificates for apps automatically.

Cloudron utilizes the `http-01` scheme to validate the domain with Lets Encrypt (this
scheme involves provisioning an HTTP resource under a well-known URI). For this reason,
the server's incoming port 80 must be kept open.

LE has a [rate limit](https://letsencrypt.org/docs/rate-limits/) of ~20 new issuances
per week per top level domain (renewals are not counted as part of this limit). This limit
means that you can install atmost 20 apps in a week across all your Cloudron instances.

We recommend purchasing a wildcard certificate if you hit those limits. [GarrisonHost](http://www.garrisonhost.com/)
provides them for 45 USD. Once purchased, it can be set as the fallback certificate in the
[Certificate UI](/documentation/certificates/#setting-fallback-wildcard-certificate). Let's Encrypt
recently [announced](https://letsencrypt.org/2017/07/06/wildcard-certificates-coming-jan-2018.html)
that they will start issuing wildcard certificates from Jan 2018, so this is expected to be a temporary
workaround.

## Automatic renewal of Let's Encrypt certificates

Cloudron attempts to start renewing certificates automatically 1 month before expiry of the
certificate. If renewal fails, a notification email will be sent to the Cloudron administrators.
If the Cloudron admin does not take any action (after getting reminded 30 times), Cloudron will start
using fallback certificates for the app.

## Setting fallback wildcard certificate

Cloudron generates a self-signed certificate for every domain it manages. This certificate is
used as the fallback if it fails to install or renew Let's Encrypt certificate. The auto-generated
fallback certificate can be replaced with a custom wildcard certificate by editing the domain
in the `Domains` page.

<br/>

<center>
<img src="/documentation/img/cert-fallback.png" class="shadow" width="600px">
</center>


## Manually renewing Let's Encrypt certificate

To manually trigger re-installation or renewal of Let's encrypt certificate, open the
app's [configure dialog](/documentation/apps/#re-configuring-an-app) and `Save` without
making any changes.

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
  subdomains are discoverable via the Certificate transparency project ([crt.sh](https://crt.sh/)
  and [Google's website](https://transparencyreport.google.com/https/certificates)) Some [hackers](https://www.golem.de/news/certificate-transparency-hacking-web-applications-before-they-are-installed-1707-129172.html) take advantage of this to   hack web applications
  before they are in installed.

## Setting custom certificates

Custom certificates can be set for each installed application using the [REST API](/developer/api/#configure-app).
This can be used to set an Extended Validation (EV) certificate for an app.

## Common reasons for Let's Encrypt Certificate failure

Here are some of the common reasons why the Cloudron might fail to get certificates via
Let's Encrypt.

* The Cloudron administrator email is not valid. Let's Encrypt requires a valid email id
  for issuing certificates. Please check the email id in the Account page.

* Let's Encrypt requires incoming port 80 to be [accepted from all IPs](https://community.letsencrypt.org/t/ip-addresses-le-is-validating-from-to-build-firewall-rule/5410/5). Note that Cloudron enforces
  port 443/HTTPS [for all communication](/documentation/security/#ssl-security) and
  any request on port 80 is redirected to HTTPS. For this reason, it is safe to keep port 80 completely open.
  Port 433/HTTPS can be restricted to specific IPs safely.

* Let's Encrypt [rate limit](https://letsencrypt.org/docs/rate-limits/) was reached.

## CAA records for Lets Encrypt

Starting Sep 2017, Lets Encrypt will check for CAA records to validate if the domain owner
has authorized the CA to issue certificates for the domain. For this reason, make sure that
either the CAA record for the domain is [empty](https://community.letsencrypt.org/t/how-to-use-without-caa/38539/2)
OR setup a CAA record allowing `letsencrypt.org`.


