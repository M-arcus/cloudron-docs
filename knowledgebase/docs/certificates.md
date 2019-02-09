# Certificates

## Overview

Cloudron integrates with [Let's Encrypt](http://letsencrypt.org/) to install certificates
for apps. Certificates are renewed automatically.

## Certificate Providers

Cloudron supports the following certificate providers:

* `Let's Encrypt Prod` - Obtain certs individually for each domain
* `Let's Encrypt Prod - Wildcard` (default) - Obtain wildcard certs for each domain
* `Let's Encrypt Staging` - Obtain certs individually for each domain from Let's Encrypt [staging endpoint](https://letsencrypt.org/docs/staging-environment/). These certs are for testing and not trusted by the browser.
* `Let's Encrypt Staging - Wildcard` - Obtain wildcard certs for each domain from Let's Encrypt [staging endpoint](https://letsencrypt.org/docs/staging-environment/). These certs are for testing and not trusted by the browser.
* `Custom Wildcard Certificate` - Disable Let's Encrypt integration and use a custom wildcard
  certificate instead.

Certificate provider can be set per-domain from the `Domains` view under the
domain's Advanced settings.

<center>
<img src="/documentation/img/certificates-provider.png" class="shadow" width="500px">
</center>

## Certificate transparency

Let's Encrypt participates in Certificate transparency. This means that your apps and
subdomains are discoverable via the Certificate transparency project ([crt.sh](https://crt.sh/)
and [Google's website](https://transparencyreport.google.com/https/certificates)). Some 
[hackers](https://www.golem.de/news/certificate-transparency-hacking-web-applications-before-they-are-installed-1707-129172.html)
take advantage of this to hack web applications before they are in installed.

For this reason, we recommend that you use Wildcard certificates. When using Wildcard certificates,
the subdomain information is not 'leaked'. Note that Let's Encrypt only allows obtaining wildcard
certificates using DNS automation. Cloudron will default to obtaining wildcard certificates when
using one of the programmatic [DNS API providers](/documentation/domains/#dns-api-providers).

## Port 80 requirement

Cloudron implements the ACMEv2 API endpoint and can obtain certificates from Let's Encrypt either
via DNS or via HTTP automation.

When using one of the programmatic [DNS API providers](/documentation/domains/#dns-api-providers),
Cloudron will use DNS automation. This means that server's incoming port 80 can be blocked.

When using the Wildcard, Manual or No-op DNS backend, Cloudron will use HTTP automation. This means
that the server's incoming port 80 has to be opened up.

## Fallback certificate

Cloudron generates a self-signed certificate for every domain it manages. This certificate is
used as the fallback if it fails to install or renew Let's Encrypt certificate. The auto-generated
fallback certificate can be replaced with a custom wildcard certificate by editing the domain
in the `Domains` page.

<br/>

<center>
<img src="/documentation/img/cert-fallback.png" class="shadow" width="600px">
</center>

## Automatic renewal

Cloudron attempts to start renewing certificates automatically 1 month before expiry of the
certificate. If renewal fails, a notification email will be sent to the Cloudron administrators.
If the Cloudron admin does not take any action (after getting reminded 30 times), Cloudron will start
using [fallback certificates](#fallback-certificate) for the app.

## Manual renewal

To instantly trigger renewal of Let's encrypt certificate, click the `Renew All` button on the domains page.

<center>
<img src="/documentation/img/certificates-renew.png" class="shadow" width="600px">
</center>

## Revokation

Cloudron does not revoke certificates when an app is uninstalled. Instead, it retains the
certificate, so that it can be reused if another app is installed in the same
subdomain. This allows you to install apps for testing in the same location, say `test`,
and not have to worry about running over the Let's Encrypt rate limit.

If required, certs can be removed manually from the `/home/yellowtent/boxdata/certs` directory.

## Custom certificates

A custom wildcard certificate can be provided per domain. When setting such a certificate,
please make sure to add both the bare domain and the wildcard domain as part of the certificate.

Follow [this tutorial](https://www.devside.net/wamp-server/generating-and-installing-wildcard-and-multi-domain-ssl-certificates)
for instructions on how to generate a custom wildcard certificate that has both the bare domain
and the wildcard domain.

Custom certificates can also be set for each installed application using the [REST API](/developer/api/#configure-app).
This can be used to set an Extended Validation (EV) certificate for an app.

## CAA records

Starting Sep 2017, Let's Encrypt will check for CAA records to validate if the domain owner
has authorized the CA to issue certificates for the domain. For this reason, make sure that
either the CAA record for the domain is [empty](https://community.letsencrypt.org/t/how-to-use-without-caa/38539/2)
OR setup a CAA record allowing `letsencrypt.org`.

