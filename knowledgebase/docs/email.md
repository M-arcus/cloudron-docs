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
* Relay all outbound mails via SendGrid, Postmark, Mailgun, AWS SES
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

## Email Settings

Email settings are located under the `Email` menu item.

<center>
<img src="/documentation/img/mail-settings.png" class="shadow" width="200px">
</center>

## Enabling Email

By default, Cloudron's mail server only sends email on behalf of apps. To enable users to
send and receive email, turn on the option under `Settings`.

<center>
<img src="/documentation/img/mail-enable.png" class="shadow" width="500px">
</center>

When using one of the programmatic [DNS backends](domains/) like Route53,
DigitalOcean or Route53, the Cloudron will automatically update the `MX`, `SPF`, `DKIM`, `DMARC` DNS records.

!!! warning "User & group mailboxes are not automatically enabled"
    Enabling email does not automatically allow users to send and receive email.
    User & Group mailboxes must be [created](#enable-mailboxes) in the `Email` view.

## Enable Mailboxes

Mailboxes can be enabled for Users and Groups on a per-domain level. To do so, simply enable
them in the Users view.

<center>
<img src="/documentation/img/mail-mailboxes.png" class="shadow" width="500px">
</center>

## Required ports for Cloudron Email

The following TCP ports must be opened in the firewall for Cloudron to send email:

* Outbound Port 25

The following TCP ports must be opened in the firewall for Cloudron to receive email:

* Inbound and Outbound Port 25
* Inbound Port 587 (SMTP/STARTTLS)
* Inbound Port 993 (IMAPS)
* Inbound Port 4190 (ManageSieve for email filters)

## Mail server setup check list

* Make sure that all the mail checks are green in the Email UI.
  <center>
  <img src="/documentation/img/mail-checks.png" class="shadow" width="500px">
  </center>

* If you are unable to send mail, first thing to check is if your VPS provider lets you
  send mail on port 25. The Cloudron UI will show a warning if it detects that it is unable
  to contact other mail servers on port 25.

    * Digital Ocean - New accounts frequently have outbound port 25 blocked. Write to their support to
      unblock your server.

    * EC2, Lightsail & Scaleway - Edit your security group to allow outbound port 25.

    * Vultr - [New accounts](https://www.vultr.com/faq/#outboundsmtp) have outbound port 25 blocked. Write
      to their support to unblock your server.

* If you are unable to receive mail, check if the security group allows inbound port 25.

* Setting up [PTR record](email/#setting-rdns-ptr-record) is crucial for mail
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
  * Username/password - Use the email id as the username and the Cloudron account password

!!! note "Multi-domain setup credentials"
    Use the email id as the username to access different mailboxes. For example, if email is
    enabled on two domains `example1.com` and `example2.com`, then use `user@example1.com`
    to access the `example1.com` mailbox and use `user@example2.com` to access the `example2.com`
    mailbox. In both cases, use the Cloudron account password.

## SMTP settings for Cloudron Email

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

## Sieve settings for Cloudron Email

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

## Creating a mail alias

One or more aliases can be configured alongside the primary email address of each
user. You can set aliases by editing the user's settings, available behind the edit
button in the user listing. Note that aliases cannot conflict with existing user or
group names.

<center>
<img src="/documentation/img/email_alias.png" class="shadow" width="600px">
</center>

!!! note "Authenticating with alias is not supported"
    Currently, it is not possible to login using the alias for SMTP/IMAP/Sieve services. Instead,
    add the alias as an identity in your mail client but login using the Cloudron credentials.

## Setting a catch-all mail address

A Catch-all or wildcard mailbox is one that will "catch all" of the emails addressed
to non-existent addresses. You can forward such emails to one or more user mailboxes
in the Email section. Note that if you do not select any mailbox (the default), Cloudron
will send a bounce.

<center>
<img src="/documentation/img/catch-all-mailbox.png" width="500" class="shadow">
</center>

## Subaddresses and tags

Emails addressed to `<username>+tag@<domain>` i.e mail addresses with a plus symbol in the
username will be delivered to the `username` mailbox. You can use this feature to give out emails of the form
`username+kayak@<domain>`, `username+aws@<domain>` and so on and have them all delivered to your mailbox.

This trick works for email aliases as well.

## Send test email

Use the 'Send Test EMail' button in the SMTP status section to test relay of email from the Cloudron.

<center>
<img src="/documentation/img/test-email-button.png" class="shadow">
</center>


## Relaying outbound mails

By default, Cloudron's built-in mail server sends out email directly to recipients.
You can instead configure the Cloudron to hand all outgoing emails to a 'mail relay'
and have the relay deliver it to recipients. Such a setup is useful when the Cloudron
server does not have a good IP reputation for mail delivery or if server service provider
does not allow sending email via port 25 (which is the case with Google Cloud and Amazon EC2).

Cloudron can be configured to send all outbound email via:

* [Amazon SES](#amazon-ses)
* Google
* Mailgun
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

## Forward all emails to an external address

To forward some or all emails to an external address, create a Sieve filter. Sieve
filters can be created using [Rainloop](apps/rainloop/),
[Roundcube](apps/roundcube/) or any other client that supports
Manage Sieve.

<center>
<img src="/documentation/img/forward-all-emails-rainloop.png" class="shadow" width="600px">
</center>

## Marking emails as spam

The spam detection agent on the Cloudron requires training to identify spam.
To do this, simply move your junk mails to the pre-created folder named `Spam`.
Most mail clients have a Junk or Spam button which does this automatically.

If you marked a mail as Spam incorrectly, just move it out to the Inbox and
the server will unlearn accordingly.

The mail server is configured to act upon training only after seeing atleast
50 spam and 50 ham messages.

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
`/home/yellowtent/boxdata/mail/haraka-config`. Note that these settings are part of
the backup and thus persisted across migrations and restores.

* `connect.rdns_access.blacklist` - Add IP addresses here (one per line) to block IPs
* `mail_from.access.blacklist` - Add mail addresses here (one per line) to block specific addresses

The mail server needs to be restarted using `docker restart mail` after editing the files
above.

## Changing the FROM address of an app

By default, Cloudron allocates the `location.app@domain` mailbox for each installed app. When
an app sends an email, the FROM address is set to `location.app@domain.com`. The mailbox name
can be changed in the [configure dialog](apps/#re-configuring-an-app) of the app.

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

## Email address restrictions

Mailboxes, lists and aliases have the following naming restrictions:
* Only alphanumerals and dot are allowed
* Maximum length of 200 characters
* Names ending with `.app` are reserved by the platform for applications
* Names with `+` and `-` are not allowed since this conflicts with the [Subaddresses and tags](##subaddresses-and-tags)
  feature. For addresses like `no-reply`, simply add a mailbox or an alias named `no`.

## Custom Domain Authentication

When using the Cloudron email server, Cloudron automatically sets up SPF, DKIM and DMARC
DNS records. To allow external services to send emails with Cloudron's domain name, these
records have to modified.

### SPF

SPF records specify which servers are allows to send emails using the Cloudron's domain
name. By default, Cloudron sets up SPF records such that only the Cloudron server itself can send
email for the domain. The record below authorizes only the Cloudron to send emails for `girish.in`.
The `~all` disallows any other server from sending emails with the From address set to `@girish.in`.

```
$ dig +short TXT girish.in
"v=spf1 a:my.girish.in ~all"
```

To authorize an external service, say mailchimp or a custom application, to send emails on behalf of
the domain, edit the SPF record to allow servers by IP or hostname. The [SPF Project](http://www.openspf.org)
has a [detailed document](http://www.openspf.org/SPF_Record_Syntax) on the syntax.

```
$ dig +short TXT girish.in
"v=spf1 a:my.girish.in include:servers.mcsv.net ip4:16.9.35.90 ~all"
```

Cloudron preserves any changes made to the SPF record across updates and migrations.

!!! note "SPF Record Type"
    Some DNS providers list a DNS record type of `SPF`. This DNS record is [obsolete](https://en.wikipedia.org/wiki/List_of_DNS_record_types#Obsolete_record_types). Use a TXT record instead.

### DKIM

DKIM records specify a public key that can be used to authenticate mails from a domain. The rough idea is
to generate a public/private key and use the private key to sign all outbound mails. The public key is listed
in the DNS and can be used to verify the email.

The DKIM keys generated by Cloudron are stored under `/home/yellowtent/boxdata/mail/dkim`. Cloudron also stores
the  public key in DNS as `cloudron._domainkey` (the DKIM selector is `cloudron`). This DKIM selector and thus
the DNS name is specific to Cloudron and each external service has it's own selector. For this reason, no changes
are required to Cloudron's DKIM records to allow external services to send email.

### DMARC

A DMARC policy specifies what action the receiver of a spoofed email must take when SPF validation
fails. For example, this policy can specify to notify the Cloudron administrator when some rogue server
is sending emails with the FROM address set to the Cloudron's domain.

By default, Cloudron sets up DMARC records to reject all mails that fail SPF validation. This way the
Cloudron administrator can feel fairly safe that nobody else is sending mails with their domain.

```
$ host -t TXT _dmarc.girish.in
_dmarc.girish.in descriptive text "v=DMARC1; p=reject; pct=100"
```

## Storage

Emails are stored in the `maildir` format under `/home/yellowtent/boxdata/mail/vmail`.

## Debugging mail delivery

* Make sure that the 'Outbound SMTP' check is green in the Email view. This step makes sure that your
  VPS provider has not blocked outbound port 25 which is required for mail delivery.

    * If it shows an error, check the status of mail container using `docker ps mail` and
      `docker exec mail supervisorctl status`.

    * If the mail container is not running, try restarting it using `docker restart mail`.

    * If the mail container appears fine, try to see if `telnet smtp.google.com 25` connects to a
      server. If it doesn't, it means that your VPS provider has blocked outgoing mail. This can
      be resolved by contacting their support.

* Send a test email via the 'Send Test Email' button. Be sure to test out atleast two different email
  address for the off chance that the VPS IP address or the domain is blacklisted one of the servers.

    * If no email is received, check the output of `docker logs -f mail` and send another test email

* When an app is not sending email, try the following:

    * Use `docker ps --format "table {{.ID}}\t{{.Labels}}"` and check the fqdn label to identify the
      container id.

    * `docker exec -ti <container id> /bin/bash`. In the shell, try sending a mail as if an app would
      send it. The command depends on whether the app is written using Go or not.

        * Non-Go apps: `swaks --server "${MAIL_SMTP_SERVER}" -p "${MAIL_SMTP_PORT}" --from "${MAIL_FROM}" --body "Test mail from cloudron app at $(hostname -f)" --auth-user "${MAIL_SMTP_USERNAME}" --auth-password "${MAIL_SMTP_PASSWORD}"`

        * Go apps: `swaks --server "${MAIL_SMTP_SERVER}" -p "${MAIL_SMTPS_PORT}" --from "${MAIL_FROM}" --body "Test mail from cloudron app at $(hostname -f)" --auth-user "${MAIL_SMTP_USERNAME}" --auth-password "${MAIL_SMTP_PASSWORD}" -tlsc`

    * If the command above works, double check how the app or the plugin is configured to send email.
      `docker exec -ti <container id> env | grep SMTP_` gives the SMTP credentials for sending email.

