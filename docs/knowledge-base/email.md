# Email

## How Cloudron Email works

## Required ports for Cloudron Email

## Setting a catch-all mail address

## Relaying outbound mails

## Creating a mailing list

## Setting mailbox aliases

## Changing the FROM address of an app

## Disabling FROM address validation

## Setting quota for a mailbox

## Configuring email filters

## Setting vacation mail

## Creating a forwarding mailbox

## Marking emails as spam

## Viewing mail server logs

## Setting rDNS record

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


