# Security

## Turnkey security

Security is a core feature of the Cloudron and we continue to push out updates
to tighten the Cloudron's security policy. Our goal is that Cloudron users should
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

## OS Updates

*   Ubuntu [automatic security updates](https://help.ubuntu.com/community/AutomaticSecurityUpdates) are enabled

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
    This means that the apps that you install and use are going to be guessable. For example,
    [crt.sh](https://crt.sh) can display all your subdomains and you can visit those subdomains and
    guess the app. Generally, this is not a problem because using hidden DNS names is not a security
    measure. If you want to avoid this, you can always use a wildcard certificate.

*   Cloudron does not collect any user information and this is not our business model. We collect
    information regarding the configured backend types. This helps us focus on improving backends
    based on their use. You can review the specific code [here](https://git.cloudron.io/cloudron/box/blob/master/src/appstore.js#L147).

## Activity log

The `Activity` view shows the activity on your Cloudron. It includes information about who is using
the apps on your Cloudron and also tracks configuration changes.

<img src="/img/activity.png" class="shadow">

## Block IPs

Cloudron uses iptables to implement rate limits and block access to incoming ports. For this purpose,
it uses the `CLOUDRON` and `CLOUDRON_RATELIMIT` chain.

## Email security

*   Cloudron checks against the [Zen Spamhaus DNSBL](https://www.spamhaus.org/zen/) before accepting mail.
*   Email can only be accessed with IMAP over TLS (IMAPS).
*   Email can only be relayed (including same-domain emails) by authenticated users using SMTP/STARTTLS.
*   Cloudron ensures that `MAIL FROM` is the same as the authenticated user. Users cannot spoof each other.
*   All outbound mails from Cloudron are `DKIM` signed.
*   Cloudron automatically sets up SPF, DMARC policies in the DNS for best email delivery.
*   All incoming mail is scanned via `Spamassasin`.

