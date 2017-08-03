# Email

## How Cloudron Email works

The Cloudron has a built-in email server. The primary email address is the same as the username. Emails can be sent
and received from `<username>@<domain>`. The Cloudron does not allow masquerading - one user cannot send email
pretending to be another user.

## Enabling Email

By default, Cloudron's email server only allows apps to send email. To enable users to send and receive email,
turn on the option under `Settings`. Turning on this option also allows apps to _receive_ email.

Once email is enabled, the Cloudron will keep the the `MX` DNS record updated.

<img src="/img/enable_email.png" class="shadow">

## Required ports for Cloudron Email

The following TCP ports must be opened in the firewall for Cloudron to send email:
* Port 25

The following TCP ports must be opened in the firewall for Cloudron to receive email:
* Port 25
* Port 587 (SMTP/STARTTLS)
* Port 993 (IMAPS)
* Port 4190 (ManageSieve for email filters)

## Receiving email using IMAP

Use the following settings to receive email.

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 993
  * Connection Security - TLS
  * Username/password - Same as your Cloudron credentials

## Sending email using SMTP

Use the following settings to send email.

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 587
  * Connection Security - STARTTLS
  * Username/password - Same as your Cloudron credentials

## Configuring email filters using sieve

Use the following settings to setup email filtering users via Manage Sieve.

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 4190
  * Connection Security - TLS
  * Username/password - Same as your Cloudron credentials

The [Rainloop](https://cloudron.io/appstore.html?app=net.rainloop.cloudronapp) and [Roundcube](https://cloudron.io/appstore.html?app=net.roundcube.cloudronapp)
apps are already pre-configured to use the above settings.

## Creating a mail alias

You can configure one or more aliases alongside the primary email address of each
user. You can set aliases by editing the user's settings, available behind the edit
button in the user listing. Note that aliases cannot conflict with existing user names.

<img src="/img/email_alias.png" class="shadow">

Currently, it is not possible to login using the alias for SMTP/IMAP/Sieve services. Instead,
add the alias as an identity in your mail client but login using the Cloudron credentials.

## Setting a catch-all mail address

A Catch-all or wildcard mailbox is one that will "catch all" of the emails addressed
to non-existent addresses. You can forward such emails to one or more user mailboxes
in the Email section. Note that if you do not select any mailbox (the default), Cloudron
will send a bounce.

<img src="/img/catch-all-mailbox.png" width="500" class="shadow">

## Subaddresses and tags

Emails addressed to `<username>+tag@<domain>` i.e mail addresses with a plus symbol in the
username will be delivered to the `username` mailbox. You can use this feature to give out emails of the form
`username+kayak@<domain>`, `username+aws@<domain>` and so on and have them all delivered to your mailbox.

This trick works for email aliases as well.

## Relaying outbound mails

By default, Cloudron's built-in email server sends out email directly to recipients.
You can instead configure the Cloudron to hand all outgoing emails to a 'mail relay'
and have the relay deliver it to recipients. Such a setup is useful when the Cloudron
server does not have a good IP reputation for mail delivery or if server service provider
does not allow sending email via port 25 (which is the case with Google Cloud and Amazon EC2).

Cloudron can be configured to send all outbound email via Amazon SES, Google, Mailgun, Postmark,
Sendgrid or any other external SMTP server. To setup a relay, enter the relay credentials in the
Email section. Cloudron only supports relaying via the STARTTLS mechanism (usually port 587).

<img src="/img/email-relay.png" width=500 class="shadow">

## Creating a mailing list

Cloudron does not support creating a mailing list i.e a list that allows members to subscribe/unsubscribe.

However, Cloudron supports creating internal mailing groups. Simply create a group and add users to it.
Any mail addressed to the `group@domain` will be forwarded to all the users.

## Changing the FROM address of an app

## Disabling FROM address validation

## Setting quota for a mailbox

Cloudron does not support mailbox quotas.

## Setting vacation mail

## Creating a forwarding mailbox

Each group on the Cloudron is also a forwarding address. Mails can be addressed
to `group@<domain>` and the mail will be sent to each user who is part of the group.

## Marking emails as spam

The spam detection agent on the Cloudron requires training to identify spam.
To do this, simply move your junk mails to a pre-created folder named `Spam`.
Most mail clients have a Junk or Spam button which does this automatically.

## Viewing mail server logs

## Setting rDNS, PTR record

rDNS (reverse DNS) or PTR records are DNS entries that can be used to resolve an IP address to a
fully-qualified domain name. For example, the PTR record of the IP 1.2.3.4 can be looked up as
`host -t PTR 4.3.2.1.in-addr.arpa`.

In the context of email, many mail servers require that the EHLO hostname used in the SMTP
connection match the PTR record. On the Cloudron, the EHLO hostname used is `my.<domain>`.
For this reason, you must set the PTR record value to be `my.<domain>`.

**The PTR record is set by your VPS provider and not by your DNS provider.**. For example,
if your server was created in Digital Ocean, you must go to Digital Ocean to set the PTR
record. We have collected a few links to help you set the PTR record for different VPS:

* AWS EC2 & Lightsail - Fill the [PTR request form](https://aws-portal.amazon.com/gp/aws/html-forms-controller/contactus/ec2-email-limit-rdns-request).

* Digital Ocean - Digital Ocean sets up a PTR record based on the droplet's name. So, simply rename
your droplet to `my.<domain>`.

* Linode - Follow this [guide](https://www.linode.com/docs/networking/dns/setting-reverse-dns).

* Scaleway - You can also set a PTR record on the interface in their control panel.

Once setup, you can verify the PTR record [https://mxtoolbox.com/ReverseLookup.aspx](here).

## Required DNS records for email

## Blacklisting domains and IPs for email

## Email security

*   Cloudron checks against the [Zen Spamhaus DNSBL](https://www.spamhaus.org/zen/) before accepting mail.
*   Email can only be accessed with IMAP over TLS (IMAPS).
*   Email can only be relayed (including same-domain emails) by authenticated users using SMTP/STARTTLS.
*   Cloudron ensures that `MAIL FROM` is the same as the authenticated user. Users cannot spoof each other.
*   All outbound mails from Cloudron are `DKIM` signed.
*   Cloudron automatically sets up SPF, DMARC policies in the DNS for best email delivery.
*   All incoming mail is scanned via `Spamassasin`.


