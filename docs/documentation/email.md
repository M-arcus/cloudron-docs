# Email

## How Cloudron Email works

Cloudron has a built-in mail server. By default, it relay mails on behalf of apps
(for example, password reset and notification emails).

When `Cloudron Email` is enabled, it becomes a full-fleged mail server solution.
Each user gets a mailbox `username@domain` and can send mails using SMTP and receive mails
using IMAP. Users can also setup mail filtering rules using ManageSieve. Features of this
mail solution include:

* Mail aliases
* Group email addresses that forward email to it's members
* Email account sub-addressing by adding `+` tag qualifier
* Setup mail filters and vacation email using ManageSieve
* Catch all mailbox to receive mail sent to a non-existent mailbox
* Relay all outbound mails via SendGrid, Postmark, Mailgun, AWS SES
* Anti-spam. Users can train the spam filter by marking mails as spam. Built-in rDNS and
  zen spamhaus lookup
* Webmail. The [Rainloop](https://cloudron.io/appstore.html?app=net.rainloop.cloudronapp) and
  [Roundcube](https://cloudron.io/appstore.html?app=net.roundcube.cloudronapp) apps are already
  pre-configured to use Cloudron Email
* Completely automated DNS setup. MX, SPF, DKIM, DMARC are setup automatically
* Let's Encrypt integration for mail endpoints
* Domains and IP addresses blacklisting
* [REST API](/documentation/developer/api/) to add users and groups
* [Secure](/documentation/security/#email-security) out of the box

## Email Settings

Email settings are located under the `Email` menu item.

<center>
<img src="/img/mail-settings.png" class="shadow" width="350px">
</center>

## Enabling Email

By default, Cloudron's mail server only sends email on behalf of apps. To enable users to
send and receive email, turn on the option under `Settings`.

<center>
<img src="/img/mail-enable.png" class="shadow">
</center>

When using one of the programmatic DNS backends like Route53, DigitalOcean or Route53, the
Cloudron will automatically update the `MX`, `SPF`, `DKIM`, `DMARC` DNS records.

## Required ports for Cloudron Email

The following TCP ports must be opened in the firewall for Cloudron to send email:

* Outbound Port 25

The following TCP ports must be opened in the firewall for Cloudron to receive email:

* Inbound and Outbound Port 25
* Inbound Port 587 (SMTP/STARTTLS)
* Inbound Port 993 (IMAPS)
* Inbound Port 4190 (ManageSieve for email filters)

## Mail server setup check list

* If you are unable to send mail, first thing to check is if your VPS provider lets you
  send mail on port 25. The Cloudron UI will show a warning if it detects that it is unable
  to contact other mail servers on port 25.

    * Digital Ocean - New accounts frequently have port outbound 25 blocked. Write to their support to
      unblock your server.

    * EC2, Lightsail & Scaleway - Edit your security group to allow outbound port 25.

* If you are unable to receive mail, check if the security group allows inbound port 25.

* Setting up [PTR record](/documentation/email/#setting-rdns-ptr-record) is crucial for mail
  to be delivered reliably to other mail servers.

* Check if your IP is listed in any DNSBL list [here](http://multirbl.valli.org/) and [here](http://www.blk.mx).
  In most cases, you can apply for removal of your IP by filling out a form at the DNSBL manager site.

* When using wildcard or manual DNS backends, you have to setup the DMARC, DKIM, MX records manually.

* Finally, check your spam score at [mail-tester.com](https://www.mail-tester.com/). The Cloudron

The server's IP plays a big role in how emails from our Cloudron get handled. Spammers
frequently abuse public IP addresses and as a result your server might possibly start
out with a bad reputation. The good news is that most IP based blacklisting services cool
down over time. The Cloudron sets up DNS entries for SPF, DKIM, DMARC automatically and
reputation should be easy to get back.

## IMAP settings for Cloudron Email

Use the following settings to receive email via IMAP:

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 993
  * Connection Security - TLS
  * Username/password - Same as your Cloudron credentials

## SMTP settings for Cloudron Email

Use the following settings to send email via SMTP:

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 587
  * Connection Security - STARTTLS
  * Username/password - Same as your Cloudron credentials

## Sieve settings for Cloudron Email

Use the following settings to setup email filtering users via Manage Sieve.

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 4190
  * Connection Security - TLS
  * Username/password - Same as your Cloudron credentials

## Creating a mail alias

One or more aliases can be configured alongside the primary email address of each
user. You can set aliases by editing the user's settings, available behind the edit
button in the user listing. Note that aliases cannot conflict with existing user or
group names.

<center>
<img src="/img/email_alias.png" class="shadow" width="600px">
</center>

Currently, it is not possible to login using the alias for SMTP/IMAP/Sieve services. Instead,
add the alias as an identity in your mail client but login using the Cloudron credentials.

## Setting a catch-all mail address

A Catch-all or wildcard mailbox is one that will "catch all" of the emails addressed
to non-existent addresses. You can forward such emails to one or more user mailboxes
in the Email section. Note that if you do not select any mailbox (the default), Cloudron
will send a bounce.

<center>
<img src="/img/catch-all-mailbox.png" width="500" class="shadow">
</center>

## Subaddresses and tags

Emails addressed to `<username>+tag@<domain>` i.e mail addresses with a plus symbol in the
username will be delivered to the `username` mailbox. You can use this feature to give out emails of the form
`username+kayak@<domain>`, `username+aws@<domain>` and so on and have them all delivered to your mailbox.

This trick works for email aliases as well.

## Relaying outbound mails

By default, Cloudron's built-in mail server sends out email directly to recipients.
You can instead configure the Cloudron to hand all outgoing emails to a 'mail relay'
and have the relay deliver it to recipients. Such a setup is useful when the Cloudron
server does not have a good IP reputation for mail delivery or if server service provider
does not allow sending email via port 25 (which is the case with Google Cloud and Amazon EC2).

Cloudron can be configured to send all outbound email via Amazon SES, Google, Mailgun, Postmark,
Sendgrid or any other external SMTP server. To setup a relay, enter the relay credentials in the
Email section. Cloudron only supports relaying via the STARTTLS mechanism (usually port 587).

<center>
<img src="/img/email-relay.png" width=500 class="shadow">
</center>

## Creating a mailing list

Cloudron does not support creating a mailing list (i.e) a list that allows members to
subscribe/unsubscribe.

Cloudron does support creating forwarding addresses. Simply create a group and add users to it.
Any mail addressed to the `group@domain` will be sent to each user who is part of the group.

## Setting quota for a mailbox

Cloudron does not support mailbox quotas.

## Creating a forwarding mailbox

Each group on the Cloudron is also a forwarding address. Mails can be addressed
to `group@<domain>` and the mail will be sent to each user who is part of the group.

## Marking emails as spam

The spam detection agent on the Cloudron requires training to identify spam.
To do this, simply move your junk mails to a pre-created folder named `Spam`.
Most mail clients have a Junk or Spam button which does this automatically.

## Setting rDNS, PTR record

rDNS (reverse DNS) or PTR records are DNS entries that can be used to resolve an IP address to a
fully-qualified domain name. For example, the PTR record of the IP 1.2.3.4 can be looked up as
`host -t PTR 4.3.2.1.in-addr.arpa`.

In the context of email, many mail servers require that the EHLO hostname used in the SMTP
connection match the PTR record. On the Cloudron, the EHLO hostname used is `my.<domain>`.
For this reason, you must set the PTR record value to be `my.<domain>`.

**The PTR record is set by your VPS provider and not by your DNS provider.**. For example,
if your server was created in Digital Ocean, you must go to Digital Ocean to set the PTR
record.

We have collected a few links to help you set the PTR record for different VPS:

* AWS EC2 & Lightsail - Fill the [PTR request form](https://aws-portal.amazon.com/gp/aws/html-forms-controller/contactus/ec2-email-limit-rdns-request).

* Digital Ocean - Digital Ocean sets up a PTR record based on the droplet's name. So, simply rename
your droplet to `my.<domain>`.

* Linode - Follow this [guide](https://www.linode.com/docs/networking/dns/setting-reverse-dns).

* Scaleway - You can also set a PTR record on the interface in their control panel.

Once setup, you can verify the PTR record [https://mxtoolbox.com/ReverseLookup.aspx](here).

## Blacklisting domains and IPs for email

Domains and IPs can be blacklisted on the mail server by editing files under
`/home/yellowtent/platformdata/mail/haraka-config`. Note that these settings are part of
the backup and thus persisted across migrations and restores.

* `connect.rdns_access.blacklist` - Add IP addresses here (one per line) to block IPs
* `mail_from.access.blacklist` - Add mail addresses here (one per line) to block specific addresses

The mail server needs to be restarted using `docker restart mail` after editing the files
above.

## Changing the FROM address of an app

By default, Cloudron allocates the `location.app@domain` mailbox for each installed app. When
an app sends an email, the FROM address is set to `location.app@domain`. The mailbox name
can be changed by modifying the database. For example, to change the `chat.app@domain` address
of an app to be just `chat`, use the following command:

```
mysql -uroot -ppassword box -e "UPDATE mailboxes SET name='chat' WHERE name='chat.app'";
```

After the command above is executed, [re-configure](/documentation/apps/#re-configuring-an-app)
the app and clicking `Save` without making any changes.

## Disabling FROM address validation

By default, the Cloudron does not allow masquerading - one user cannot send email pretending
to be another user.

This can be disabled using the [API](/documentation/developer/api/#set-mail-from-validation).

## Setting vacation mail

An out of office / vacation mail message can be setup using Sieve filters. When using
Rainloop, a vacation message can be set in `Settings` -> `Filters` -> `Add filter` -> `Vacation message` action.

<center>
<img src="/img/email-vacation-message.png" class="shadow" width="600px">
</center>
