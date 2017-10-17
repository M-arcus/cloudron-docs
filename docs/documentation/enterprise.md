# Enterprise

## What is Cloudron Enterprise

Cloudron Enterprise is targeted at cloud service providers and medium to large
businesses.

With an enterprise subscription, Cloud service providers can install Cloudron 
on a non-registrable domain like `customer.myhosting.com`. This allows for setups
where you can host Cloudrons under a top level domain for each of your customers
like `customer1.myhosting.com`, `customer2.myhosting.com` and so on.

For businesses, Cloudron Enterprise provides multi-host functionality which
allows for a single Cloudron installation across multiple servers.

Other features of Cloudron Enterprise include:

* White labeling - You can re-brand the Cloudron web interface and emails as your
  own.

* 4-hour response time for support requests

## Installation

To install Cloudron Enterprise, first contact us for a trial at [support@cloudron.io](mailto:support@cloudron.io)
for an enterprise subscription.

Once you have a subscription, follow the 3 simple steps in our [installation guide](/documentation/installation/).
The main difference from the non-enterprise version is that you have to navigate to `https://<IP>?enterprise=true`
to complete the setup.

## Lets Encrypt

Cloudron uses [Let's Encrypt](https://letsencrypt.org) for provisioning TLS certificates for apps. LE has a 
[rate limit](https://letsencrypt.org/docs/rate-limits/) of ~20 new issuances per week per top level domain (renewals
are not counted as part of this limit). This limit means that you can install atmost 20 apps in a week across all
your Cloudron instances.

We recommend purchasing a wildcard certificate. [GarrisonHost](http://www.garrisonhost.com/) provides them for 45 USD.
Once purchased, it can be set as the fallback certificate in the [Certificate UI](/documentation/certificates/#setting-fallback-wildcard-certificate). Let's Encrypt recently [announced](https://letsencrypt.org/2017/07/06/wildcard-certificates-coming-jan-2018.html)
that they will start issuing wildcard certificates from Jan 2018, so this is expected to be a temporary workaround.

