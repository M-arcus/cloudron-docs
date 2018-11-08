# Security

## Turnkey security

Security is a core feature of Cloudron and we continue to push out updates
to tighten the Cloudron firewall's security policy. Our goal is that Cloudron users should
be able to rely on Cloudron being secure out of the box without having to do manual
configuration.

## HTTP Security

*   All apps on the Cloudron can only be reached by `https`. `http` automatically redirects
    to `https`.
*   Cloudron admin has a CSP policy that prevents XSS attacks.
*   Cloudron set various security related HTTP headers like `X-XSS-Protection`, `X-Download-Options`,
    `X-Content-Type-Options`, `X-Permitted-Cross-Domain-Policies`, `X-Frame-Options` across all apps.

## SSL Security

*   Cloudron enforces HTTPS across all apps. HTTP requests are automatically redirected to
    HTTPS.
*   Cloudron supports Let's Encrypt wildcard certificates that help in hiding the subdomain of apps.
*   The Cloudron automatically installs and renews certificates for your apps as needed. Should
    installation of certificate fail for reasons beyond it's control, Cloudron admins will get a notification about it.
*   Cloudron sets the `Strict-Transport-Security` header (HSTS) to protect apps against downgrade attacks
    and cookie hijacking.
*   Cloudron has A+ rating for SSL from [SSL Labs](https://cloudron.io/blog/2017-02-22-release-0.102.0.html).

## App isolation and sandboxing

*   Apps are isolated completely from one another. One app cannot tamper with another apps' database or
    local files. We achieve this using Linux Containers.
*   Apps run with a read-only rootfs preventing attacks where the application code can be tampered with.
*   Apps can only connect to addons like databases, LDAP, email relay using authentication.
*   Apps are run with an AppArmor profile that disables many system calls and restricts access to `proc`
    and `sys` filesystems.
*   Most apps are run as non-root user. In the future, we intend to implement user namespaces.
*   Each app is run in it's own subdomain as opposed to sub-paths. This ensures that XSS vulnerabilities
    in one app doesn't [compromise](https://security.stackexchange.com/questions/24155/preventing-insecure-webapp-on-subdomain-compromise-security-of-main-webapp) other apps.

## TCP Security

*   Cloudron blocks all incoming ports except 22 (ssh), 80 (http), 443 (https)
*   When email is enabled, Cloudron allows 25 (SMTP), 587 (MSA), 993 (IMAPS) and 4190 (WebSieve)

## Updates

### Signed releases

Cloudron platform updates are signed and verified using GPG. Cloudron releases are signed using a GPG
key by a Cloudron team member. Cloudron installations download the release packages and verify the
signature before applying the updates.

The GPG keys used for signing release packages are maintained offline. This security mechanism means that
Cloudron installations will not be compromised even if the Cloudron's cloud infrastructure is compromised.

### OS Updates

Ubuntu [automatic security updates](https://help.ubuntu.com/community/AutomaticSecurityUpdates) are enabled

## Rate limits

The goal of rate limits is to prevent password brute force attacks.

*   Cloudron password verification routes - 10 requests per second per IP.
*   HTTP and HTTPS requests - 5000 requests per second per IP.
*   SSH access - 5 connections per 10 seconds per IP.
*   Email access (Port 25, 587, 993, 4190) - 50 connections per second per IP/App.
*   Database addons access - 5000 connections per second per app (addons use 128 byte passwords).
*   Email relay access - 500 connections per second per app.
*   Email receive access - 50 connections per second per app.
*   Auth addon access - 500 connections per second per app.

## Password restrictions

*   Cloudron requires user passwords to have 1 uppercase, 1 number and 1 symbol.
*   Minimum length for user passwords is 8
*   Passwords are individually salted and hashed using PKBDF2 (Section 5.1 of https://www.ietf.org/rfc/rfc2898.txt)

## Privacy

*   Cloudron apps have a default `Referrer-Policy` of `no-referrer-when-downgrade`.

*   Backups are optionally encrypted with AES-256-CBC.

*   Let's Encrypt [submits](https://letsencrypt.org/certificates/)
    all certificates to [Certificate Transparency Logs](https://www.certificate-transparency.org/).
    This is an important consideration when using non-wildcard Let's Encrypt certificates
    because apps that you install and use are going to be listed in the logs. For example,
    [crt.sh](https://crt.sh), [Google transparency report](https://transparencyreport.google.com/https/certificates)
    can display all your subdomains and you can visit those subdomains and
    guess the app. Please note that this is not a problem when using wildcard certs.

*   Cloudron does not collect any user information and this is not our business model. We collect
    information regarding the configured backend types. This helps us focus on improving backends
    based on their use. You can review the specific code [here](https://git.cloudron.io/cloudron/box/blob/master/src/appstore.js#L147).

## Activity log

The `Activity` view shows the activity on your Cloudron. It includes information about who is using
the apps on your Cloudron and also tracks configuration changes.

<center>
<img src="/documentation/img/activity.png" class="shadow" width="600px">
</center>

## Configuring Cloud Firewall

Cloudron automatically configures the server's OS firewall (iptables) as required. We highly recommend
**not** modifying iptables with `iptables`, `ufw` and other tools. Instead, please use the firewall
provided by the VPS provider for further hardening. For example, on AWS this would be security group
settings, on Digital Ocean the Firewall settings etc.

### Inbound ports

| Port | Notes |
|------|------ |
| 22 or 202 (SSH/TCP)  | Required for SSH access to the server. We recommend disabling password based access and moving this to a different port. See [this guide](#securing-ssh-access). |
| 80 (HTTP/TCP)  | When using manual and wildcard DNS, Let's Encrypt certificates require this port to be open. This port can be blocked when using programmatic DNS. |
| 443 (HTTPS/TCP) | Required for accessing the web page of all apps. |
| 25 (SMTP/TCP) | Required for receiving email. When not using Cloudron Email, this can be blocked. |
| 587 (SMTP/TCP) | Required for sending email from mobile phone or desktop apps. When using only webmail or not using Cloudron Email, this port can be blocked. |
| 443 (IMAP/TCP) | Required for accessing email from mobile phone or desktop apps. When using only webmail or not using Cloudron Email, this port can be blocked. |
| 4190 (Sieve/TCP) | Required for accessing email filters from mobile phone or desktop apps. When using only webmail or not using Cloudron Email, this port can be blocked. |
| Other ports | Other ports have to be opened up depending on the apps installed. For example, the git+ssh port has to be opened when using GitLab |

### Outbound ports

We recommend leaving all outbound ports open. Some providers like AWS EC2, Google Cloud, Digital Ocean forcefully
block outbound port 25 for reducing email spam. The only way around this is to either request your server provider
to unblock this port or better to setup an [Email relay](/documentation/email#relaying-outbound-mails).

## Securing SSH access

It is highly recommended to disable password based access to your server since many online
attackers brute force passwords. Configuring SSH access to be based on a SSH key secures
the server with the equivalent of a 634 length password with random letters and numbers.
It is [not possible](https://blog.codinghorror.com/brute-force-key-attacks-are-for-dummies/)
to brute force SSH keys even with modern technology.

To disable password authentication, check for the following line in `/etc/ssh/sshd_config`:
```
PasswordAuthentication no
PermitRootLogin yes        # If set to 'yes', store the ssh keys in root user (/root/.ssh/authorized_keys)
                           # If set to 'no', store the ssh keys in sudo user (/home/ubuntu/.ssh/authorized_keys)
```

By default, the SSH server runs on port 22. We recommend moving this to port 202 to prevent
brute force attacks. Be careful to not lock yourself out when following the instructions below.

To change the SSH port, change the following line in `/etc/ssh/sshd_config`:
```
Port 202   # Do not use any other port. Only this port is not blocked by the Cloudron firewall
```

!!! note "Port 202"
    Note that we carefully chose port 202 because this port is specifically unblocked in `iptables`
    during the Cloudron installation. If you choose some other port, you have to configure `iptables`
    manually and be sure to persist those changes across reboots.

The SSH service can be restarted using `systemctl restart sshd`. Use `ssh -p 202 root@ip` to
connect to the server.


## Block IPs

Cloudron uses iptables to implement rate limits and block access to incoming ports. For this purpose,
it uses the `CLOUDRON` and `CLOUDRON_RATELIMIT` chain. These chains are managed by Cloudron and should
not be edited. Cloudron creates these chains at installation time and on every reboot automatically.
If these chains are already present, it will not alter the position of the chains in the iptables.
With this information, you can add custom rules and chains before and after the `CLOUDRON` and
`CLOUDRON_RATELIMIT`.

### Fail2Ban

Fail2Ban reads app log files and automatically block IPs. Be aware that Fail2Ban only
works partially on Cloudron because most apps do not log failed authenticated attempts in a manner that
Fail2Ban can parse (even if they did, Cloudron's reverse proxy hides the remote IP). That said, Fail2Ban can
be used to block brute force SSH logins by simply installing it:

```
apt install fail2ban
```

### Static IP ranges

It is also possible to blacklist IPs manually using iptables. Before resorting to the approach below,
we recommend investigating blocking IPs using your service provider's firewall settings instead. For example,
[AWS Security Groups](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/using-network-security.html),
[Azure Network Security Groups](https://docs.microsoft.com/en-us/azure/virtual-network/virtual-networks-nsg)
or [Digital Ocean Firewall](https://www.digitalocean.com/community/tutorials/an-introduction-to-digitalocean-cloud-firewalls).
These solutions have the advantage that traffic is blocked at the network edge of the service provider (as
opposed to the VM's kernel).

For an iptables based approach, just prepend rules to the `INPUT` chain:

```
iptables -I INPUT -s 192.168.1.1 -j DROP            # Drop a specific IP
iptables -I INPUT -s 192.168.0.0/16 -j DROP         # Drop a whole block of IPs
```

To persist the changes across reboots:

```
apt install iptables-persistent          # this is a service that restores iptables
iptables-save >/etc/iptables/rules.v4    # current snapshot of iptables
```

### Geo IP block

Please note that these instructions are provided here for convenience. Please make sure that you
understand each command before executing them to prevent yourself from being locked out of the
server.

Create and insert an IPSet named `BLACKLIST` by following the instructions:

```
apt install ipset unzip
ipset create BLACKLIST hash:net

# download the database
wget http://geolite.maxmind.com/download/geoip/database/GeoIPCountryCSV.zip

# convert the CSV to ipset format
awk -F "," -v COUNTRY_CODE=CN -v IPSET_TABLE=BLACKLIST '$5 ~ COUNTRY_CODE { gsub(/"/, "", $1); gsub(/"/, "", $2); print "add "IPSET_TABLE" "$1"-"$2; }' GeoIPCountryWhois.csv > ipset.BLACKLIST.conf

ipset restore < ipset.BLACKLIST.conf    # 'ipset list BLACKLIST' can be used to list contents
iptables -I INPUT -p tcp -m set --match-set BLACKLIST src -j DROP
```

To persist the changes across reboots:

```
apt install iptables-persistent          # this is a service that restores iptables
iptables-save > /etc/iptables/rules.v4    # current snapshot of iptables
```

The content above was derived from [here](https://superuser.com/questions/997426/is-there-any-other-way-to-get-iptables-to-filter-ip-addresses-based-on-geolocati).

## Email security

*   Cloudron checks against the [Zen Spamhaus DNSBL](https://www.spamhaus.org/zen/) before accepting mail.
*   Email can only be accessed with IMAP over TLS (IMAPS).
*   Email can only be relayed (including same-domain emails) by authenticated users using SMTP/STARTTLS.
*   Cloudron ensures that `MAIL FROM` is the same as the authenticated user. Users cannot spoof each other.
*   All outbound mails from Cloudron are `DKIM` signed.
*   Cloudron automatically sets up SPF, DMARC policies in the DNS for best email delivery.
*   All incoming mail is scanned via `Spamassasin`.

