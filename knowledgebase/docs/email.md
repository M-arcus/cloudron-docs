# Email

## How Cloudron Email works

Cloudron has a built-in mail server that can send and receive email on behalf of users
and applications. By default, most of it's functionality is disabled and it only sends out
mails on behalf of apps (for example, password reset and notification emails).

When `Cloudron Email` is [enabled](#enabling-email), it becomes a full-fleged mail server solution.
Each user gets a mailbox `username@domain` and can send mails using SMTP and receive mails
using IMAP. Users can also setup server side mail filtering rules using ManageSieve.

Features of this mail solution include:

* Multi-domain support
* Enable mailboxes for users and groups on a domain level
* Per-user mail aliases
* Group email addresses that forward email to it's members
* Email account sub-addressing by adding `+` tag qualifier
* Setup mail filters and vacation email using ManageSieve
* Catch all mailbox to receive mail sent to a non-existent mailbox
* Relay all outbound mails via SendGrid, Postmark, Mailgun, AWS SES or a Smart host
* Anti-spam. Users can train the spam filter by marking mails as spam. Built-in rDNS and
  zen spamhaus lookup
* Webmail. The [Rainloop](https://cloudron.io/appstore.html?app=net.rainloop.cloudronapp) and
  [Roundcube](https://cloudron.io/appstore.html?app=net.roundcube.cloudronapp) apps are already
  pre-configured to use Cloudron Email
* Completely automated DNS setup. MX, SPF, DKIM, DMARC are setup automatically
* Let's Encrypt integration for mail endpoints
* Domains and IP addresses blacklisting
* [REST API](../developer/api/) to add users and groups
* [Secure](security/#email-security) out of the box

<br/>

Email settings are located under the `Email` menu item.

<center>
<img src="/documentation/img/mail-settings.png" class="shadow" width="200px">
</center>

## Setting up Email

### Enabling Email

By default, Cloudron's mail server only sends email on behalf of apps. To enable users to
**receive** email, turn on the option under `Settings`.

<center>
<img src="/documentation/img/mail-enable.png" class="shadow" width="500px">
</center>

When using one of the programmatic [DNS backends](domains/) like Route53,
DigitalOcean or Route53, the Cloudron will automatically update the `MX`, `SPF`, `DKIM`, `DMARC` DNS records.

### Required ports for Cloudron Email

The following TCP ports must be opened in the firewall for Cloudron to send email:

* Outbound Port 25

If outbound port 25 is blocked by your server provider, [setup an email relay](#relaying-outbound-mails).
You can check if outbound port 25 is blocked by sending yourself a [test email](#send-test-email)
from the Cloudron.

The following TCP ports must be opened in the firewall for Cloudron to receive email:

* Inbound and Outbound Port 25
* Inbound Port 587 (SMTP/STARTTLS)
* Inbound Port 993 (IMAPS)
* Inbound Port 4190 (ManageSieve for email filters)

### Mail server status

Make sure that all the mail checks are green in the Email UI. Please note that the UI below
displays the check list depending on whether incoming email is enabled and whether a mail
relay is setup.

<center>
<img src="/documentation/img/mail-checks.png" class="shadow" width="500px">
</center>

If one or more checkboxes are not green, see the [debugging section](#debugging-mail).

## Creating Mailboxes

Mailboxes can be created for Users and Groups on a per-domain level. To do so, simply create
them in the `Email` view.

<center>
<img src="/documentation/img/mail-add-mailbox.png" class="shadow" width="500px">
</center>

The `Mailbox Owner` dropdown can be used to select an existing user. The user can then access their
email using the new email and the Cloudron password. i.e The user `johannes` can now use his password
to access the `johannes@smartserver.space` mailbox using [SMTP](#smtp-settings-for-cloudron-email) and
[IMAP](##imap-settings-for-cloudron-email).

Mailboxes have the following naming restrictions:

* Only alphanumerals, dot and '-' are allowed
* Maximum length of 200 characters
* Names ending with `.app` are reserved by the platform for applications
* Names with `+` are not allowed since this conflicts with the [Subaddresses and tags](##subaddresses-and-tags)
  feature. 

## Creating Mail aliases

One or more aliases can be configured for each mailbox. You can do this by editing the mailbox
configuration:

<center>
<img src="/documentation/img/mail-alias.png" class="shadow" width="500px">
</center>

!!! note "Authenticating with alias is not supported"
    Currently, it is not possible to login using the alias for SMTP/IMAP/Sieve services. Instead,
    add the alias as an identity in your mail client but login using the Cloudron credentials.

## Creating Mailing Group

A Mailing group forwards emails to one or more existing mailboxes. A list can be created in the `Email` view.

<center>
<img src="/documentation/img/mail-add-maillist.png" class="shadow" width="500px">
</center>

!!! note "No subscribe/unsubscribe feature"
    Cloudron does not support creating a mailing list (i.e) a list that allows members to
    subscribe/unsubscribe.

## Setting a catch-all mail address

A Catch-all or wildcard mailbox is one that will "catch all" of the emails addressed
to non-existent addresses. You can forward such emails to one or more user mailboxes
in the Email section. Note that if you do not select any mailbox (the default), Cloudron
will send a bounce.

<center>
<img src="/documentation/img/catch-all-mailbox.png" width="500" class="shadow">
</center>



## Accessing Cloudron Email

### IMAP

Use the following settings to receive email via IMAP:

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 993
  * Connection Security - TLS
  * Username/password - Use the email id as the username and the Cloudron account password

!!! note "Multi-domain setup credentials"
    Use the email id as the username to access different mailboxes. For example, if email is
    enabled on two domains `example1.com` and `example2.com`, then use `user@example1.com`
    to access the `example1.com` mailbox and use `user@example2.com` to access the `example2.com`
    mailbox. In both cases, use the Cloudron account password.

### SMTP

Use the following settings to send email via SMTP:

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 587
  * Connection Security - STARTTLS
  * Username/password - Use the full email as the username and the Cloudron account password

!!! note "Multi-domain setup credentials"
    Use the email id as the username to send email. For example, if email is
    enabled on two domains `example1.com` and `example2.com`, then use `user@example1.com`
    to send email as `example1.com` and use `user@example2.com` to send email as `example2.com`.
    In both cases, use the Cloudron account password.

### Sieve

Use the following settings to setup email filtering users via ManageSieve.

  * Server Name - Use the `my` subdomain of your Cloudron
  * Port - 4190
  * Connection Security - STARTTLS
  * Username/password - Use the full email as the username and the Cloudron account password

!!! note "Multi-domain setup credentials"
    Use the email id as the username to access different mailboxes. For example, if email is
    enabled on two domains `example1.com` and `example2.com`, then use `user@example1.com`
    to access the `example1.com` mailbox and use `user@example2.com` to access the `example2.com`
    mailbox. In both cases, use the Cloudron account password.

## Subaddresses and tags

Emails addressed to `<username>+tag@<domain>` i.e mail addresses with a plus symbol in the
username will be delivered to the `username` mailbox. You can use this feature to give out emails of the form
`username+kayak@<domain>`, `username+aws@<domain>` and so on and have them all delivered to your mailbox.

This trick works for email aliases as well.

## Relaying outbound mails

By default, Cloudron's built-in mail server sends out email directly to recipients.
You can instead configure the Cloudron to hand all outgoing emails to a 'mail relay'
or a 'smart host' and have the relay deliver it to recipients. Such a setup is useful when the Cloudron
server does not have a good IP reputation for mail delivery or if server service provider
does not allow sending email via port 25 (which is the case with Google Cloud and Amazon EC2).

Cloudron can be configured to send outbound email via:

* [Amazon SES](#amazon-ses)
* Google
* Mailgun
* Mailjet
* Postmark
* Sendgrid
* [Office 365](#office-365)
* Any other external SMTP server.

To setup a relay, enter the relay credentials in the Email section. Cloudron only supports relaying
via the STARTTLS mechanism (usually port 587).

<center>
<img src="/documentation/img/email-relay.png" width=500 class="shadow">
</center>

### Amazon SES

To setup Cloudron to relay via Amazon SES:

* Go to Amazon SES dashboard and add a new domain to verify under `Domains`. Leave the `Generate DKIM Settings` unchecked
  since Cloudron has already generated DKIM keys.
    * Setup the DNS records as suggested by the `Verify a New Domain`. SES will automatically set
      these up if your domain is on AWS Route53.

* Once domain is verified, click on `SMTP Settings` on the left pane and then click the `Create My SMTP Credentials`
  button.
    * Follow through the wizard to create a new IAM user that has the following policy

    ```
        "Statement": [{  "Effect":"Allow",  "Action":"ses:SendRawEmail",  "Resource":"*"}]
    ```

* Setup the relay on the Cloudron under the Email section:

<center>
<img src="/documentation/img/email-relay-ses.png" width=500 class="shadow">
</center>

* Use the [Send Test Email](#send-test-email) button to verify emails are sent.

* If you do not receive the email, please verify that your AWS SES is not in sandbox mode. In this mode, new AWS
   accounts are only able to send mails to verified domains or the simulator. You can check this in the
   `Sending Statistics` page and looking for a note that looks like below:

<center>
<img src="/documentation/img/ses-sandbox.png" width=500 class="shadow">
</center>

To remove sandbox, log a request to increase the sending limit to say 500 emails a day.

### Google

When using Google to relay mail, if you encounter an error message of the form `Invalid login` or
`Please log in via your web browser and then try again`, you must configure your Google account
to either use App passwords or enable less secure apps. See [Google Support](https://support.google.com/mail/answer/7126229?visit_id=1-636433350211034673-1786624518&rd=1#cantsignin) for more information.

### Office 365

To setup Office 365 as relay, add a connector under mail flow following the instructions under [Option 3](https://support.office.com/en-us/article/How-to-set-up-a-multifunction-device-or-application-to-send-email-using-Office-365-69f58e99-c550-4274-ad18-c805d654b4c4). Note that relaying via Office 365 requires port 25 to be open and requires a static IP.

## Setting quota for a mailbox

Cloudron does not support mailbox quotas.

## Forward all emails to an external address

To forward some or all emails to an external address, create a Sieve filter. Sieve
filters can be created using [Rainloop](apps/rainloop/),
[Roundcube](apps/roundcube/) or any other client that supports
Manage Sieve.

<center>
<img src="/documentation/img/forward-all-emails-rainloop.png" class="shadow" width="600px">
</center>

!!! warning "Limited support"
    Cloudron Email server currently does not implement [SRS](http://www.openspf.org/SRS). For this
    reason, this feature may not work depending on your forwarded address.

## Marking emails as spam

The spam detection agent on the Cloudron requires training to identify spam.
To do this, simply move your junk mails to the pre-created folder named `Spam`.
Most mail clients have a Junk or Spam button which does this automatically.

If you marked a mail as Spam incorrectly, just move it out to the Inbox and
the server will unlearn accordingly.

The mail server is configured to act upon training only after seeing atleast
50 spam and 50 ham messages.

## Blacklisting domains and IPs for email

Domains and IPs can be blacklisted on the mail server by editing files under
`/home/yellowtent/boxdata/mail/haraka-config`. Note that these settings are part of
the backup and thus persisted across migrations and restores.

* `connect.rdns_access.blacklist` - Add IP addresses here (one per line) to block IPs
* `mail_from.access.blacklist` - Add mail addresses here (one per line) to block specific addresses

The mail server needs to be restarted using `docker restart mail` after editing the files
above.

## Changing the FROM address of an app

By default, Cloudron allocates the `location.app@domain` mailbox for each installed app. When
an app sends an email, the FROM address is set to `location.app@domain.com`. The mailbox name
can be changed in the [configure dialog](apps/#configuring-an-app) of the app.

<center>
<img src="/documentation/img/apps-mailbox-name.png" class="shadow" width="600px">
</center>

## Disabling FROM address validation

By default, the Cloudron does not allow masquerading - one user cannot send email pretending
to be another user. To disable this, enable masquerading in the Email settings.

<center>
<img src="/documentation/img/email-masquerading.png" class="shadow" width="600px">
</center>

## Setting vacation mail

An out of office / vacation mail message can be setup using Sieve filters. When using
Rainloop, a vacation message can be set in `Settings` -> `Filters` -> `Add filter` -> `Vacation message` action.

<center>
<img src="/documentation/img/email-vacation-message-rainloop.png" class="shadow" width="600px">
</center>

