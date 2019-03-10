# Troubleshooting

This section will provide some general overview where to find log output and how to check relevant service states.

## Dashboard

If the Cloudron dashboard is down/not reachable, try the following steps:

* Check the output of `host my.<domain>` on your PC and verify that the IP address is pointing to your server.
* Try `systemctl status box` on the server. If it's not running, try `systemctl restart cloudron.target`

If the dashboard was using a domain that you no longer control and you want to switch it to
a new domain, do the following:

* Add the new domain (e.g `example.com`) in the `Domains` view.

* Edit `/home/yellowtent/configs/cloudron.conf`
    * Change `adminDomain` to `example.com`
    * Change `adminFqdn` to `my.example.com`

    !!! note "Do not change adminLocation"
        The `adminLocation` seems to be customizable but changing this to any value other than `my`
        will break the installation

* Add an A record manually in your DNS provider for `my.example.com` to your server's IP

* Run the following command to update the OAuth endpoint (change `example.com` in the command below):

```
    mysql -uroot -ppassword --database=box -e "UPDATE clients SET redirectURI='https://my.example.com' WHERE type='built-in'"
```
* Run the command `systemctl restart cloudron.target`

In a few minutes, you should be able to reach `https://my.example.com`.

## Unresponsive apps

If the apps are unresponsive, try the following steps:

* Check the status of docker in the `Systems` view
* Try restarting docker from the `Systems` view

## Identifying App container

Cloudron creates app containers with the `location` and `appId` label set. For example,
to find the container id of the app running on the `redmine.smartserver.io` domain:

```
docker ps -f label=fqdn=redmine.smartserver.io
```

To view all container and the apps they correspond to:

```
docker ps --format "table {{.ID}}\t{{.Labels}}"
```

## Backups

If you see a message like `task crashed with code null and signal SIGKILL`, this probably means the backup task
is running out of memory.

To rectify this, SSH into the server:

* Edit `/etc/systemd/system/box.service` and change the line that says `MemoryLimit=200M` to `MemoryLimit=400M`.
* `systemctl daemon-reload`
* `systemctl restart box`

The backup logs can be viewed and downloaded using the `Show Logs` button in the `Backups` view.

<center>
<img src="/documentation/img/backups-logs.png" class="shadow" width="500px">
</center>

## Logs

Logs for each component are located in `/home/yellowtent/platformdata/logs/`. Many of these logs are viewable
directly using the Cloudron dashboard in the `support`, `mail` or `system` view.

## Recovery after disk full

One or more system services may go down if the disk becomes full. Once some space has been freed up,
follow the steps below to repair the Cloudron:

## Services

The `System` view displays the current status of the internal services on the Cloudron. Cloudron will
send notifications if these services are running out of memory or down.

To adjust the memory limit for a service, use the memory limit slider:

<center>
<img src="/documentation/img/system-memorylimit.png" class="shadow" width="500px">
</center>


### Unbound

Cloudron uses an internal DNS server called `unbound`. This server [stops working](https://www.nlnetlabs.nl/bugs-script/show_bug.cgi?id=547)
if it is unable to save the [trust anchor](https://www.dnssec-tools.org/wiki/index.php?title=Trust_Anchor) file. To get it
running again, one has to re-download the root key and restart the unbound service.

First, check the status of unbound using:

```
systemctl status unbound
```

It must say `active (running)`. If not, run the following commands:

```
unbound-anchor -a /var/lib/unbound/root.key
systemctl restart unbound
```

### Nginx

Check the status of nginx:
```
systemctl status nginx
```

If nginx is not running:
```
systemctl restart nginx
```

### Docker

Docker can be restarted using the following command:
```
systemctl restart docker
```

Note that the above command will restart all the apps and addon services.

### MySQL

Check if MySQL is running using:
```
systemctl status mysql
```

If it is not, check the contents of the file `/var/log/mysql/error.log`.

Sometimes, the only way is to recreate the database from a dump. For this, re-create
a database dump like so:

```
mysqldump -uroot -ppassword --single-transaction --routines --triggers box > box.mysql
mysql -uroot -ppassword -e "DROP DATABASE box"
mysql -uroot -ppassword -e "CREATE DATABASE IF NOT EXISTS box"
mysql -uroot -ppassword box < box.mysql
```

## Certificates

Here are some of the common reasons why the Cloudron might fail to get certificates via
Let's Encrypt.

* The Cloudron administrator email is not valid. Let's Encrypt requires a valid email id
  for issuing certificates. Please check the email id in the Account page.

* Let's Encrypt requires incoming port 80 to be [accepted from all IPs](https://community.letsencrypt.org/t/ip-addresses-le-is-validating-from-to-build-firewall-rule/5410/5). Note that Cloudron enforces
  port 443/HTTPS [for all communication](security/#ssl-security) and
  any request on port 80 is redirected to HTTPS. For this reason, it is safe to keep port 80 completely open.
  Port 433/HTTPS can be restricted to specific IPs safely.

* Let's Encrypt [rate limit](https://letsencrypt.org/docs/rate-limits/) was reached.

* Make sure that the DNS credentials for the domain are still valid. You can check by this
  by clicking 'Edit domain' in the `Domains` view and saving it without making any changes.

* If all looks good, click the 'Renew All' button in `Domains` view to renew all the certs.
  See the logs for more information on why certificate renewal might be failing.

## Mail DNS

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

### rDNS, PTR record

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

* Netcup -  You can enter a reverse lookup in the customer area CCP for your vServer - [wiki doc](https://www.netcup-wiki.de/wiki/Produkte_CCP#rDNS)

* Scaleway - You can also set a PTR record on the interface in their control panel.

Once setup, you can verify the PTR record [https://mxtoolbox.com/ReverseLookup.aspx](here).

### Blacklists

The server's IP plays a big role in how emails from our Cloudron get handled. Spammers
frequently abuse public IP addresses and as a result your server might possibly start
out with a bad reputation. The good news is that most IP based blacklisting services cool
down over time. The Cloudron sets up DNS entries for SPF, DKIM, DMARC automatically and
reputation should be easy to get back.

## Mail SMTP

### Outbound Mail delivery

Use the 'Send Test Email' button in the SMTP status section to send an email from the Cloudron.

<center>
<img src="/documentation/img/test-email-button.png" class="shadow">
</center>

If you did not receive email from Cloudron, first thing to check is if your VPS provider lets you
send mail on port 25. The Cloudron UI will show a warning if it detects that it is unable
to contact other mail servers on port 25.

  * Digital Ocean - New accounts frequently have outbound port 25 blocked. Write to their support to
    unblock your server.

  * EC2, Lightsail & Scaleway - Edit your security group to allow outbound port 25.

  * Vultr - [New accounts](https://www.vultr.com/faq/#outboundsmtp) have outbound port 25 blocked. Write
    to their support to unblock your server.

* Setting up [PTR record](email/#setting-rdns-ptr-record) is crucial for mail
  to be delivered reliably to other mail servers.

* Check if your IP is listed in any DNSBL list [here](http://multirbl.valli.org/) and [here](http://www.blk.mx).
  In most cases, you can apply for removal of your IP by filling out a form at the DNSBL manager site.

* When using wildcard or manual DNS backends, you have to setup the DMARC, DKIM, MX records manually.

* Finally, check your spam score at [mail-tester.com](https://www.mail-tester.com/).

When an app is not sending email, try the following:

* Open a [Web terminal](apps/#web-terminal) of the app.

* For apps that do not use Go: `swaks --server "${MAIL_SMTP_SERVER}" -p "${MAIL_SMTP_PORT}" --from "${MAIL_FROM}" --body "Test mail from cloudron app at $(hostname -f)" --auth-user "${MAIL_SMTP_USERNAME}" --auth-password "${MAIL_SMTP_PASSWORD}"`

* For apps that use Go: `swaks --server "${MAIL_SMTP_SERVER}" -p "${MAIL_SMTPS_PORT}" --from "${MAIL_FROM}" --body "Test mail from cloudron app at $(hostname -f)" --auth-user "${MAIL_SMTP_USERNAME}" --auth-password "${MAIL_SMTP_PASSWORD}" -tlsc`

### Inbound Mail delivery

* If you are unable to receive mail, check if the security group allows inbound port 25.
* Ensure that your domain's `MX` record points to the Cloudron.

