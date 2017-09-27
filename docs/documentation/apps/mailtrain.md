# <img src="/img/mailtrain-logo.png" width="25px"> Mailtrain App

## VERP handling

VERP is a feature where bounces are sent back to _special_ addresses.
Mailtrain [supports VERP](https://github.com/Mailtrain-org/mailtrain#5-set-up-verp)
and can be configured to process these bounces and automatically unsubscribe
addresses that are bouncing.

On the Cloudron, VERP handling is disabled because Cloudron's mail server
does not support it. We plan to add this feature in a future release. Rest
assured, Mailtrain can be used without any issue when VERP is not setup.

For now, bounces are sent to the Email "reply-to" address in the campaign
and have to be processesed manually.

## Changing Email "from" Address

Cloudron's email server does not allow apps to send emails with arbitrary
FROM addresses. This is a simple security measure that prevents apps from
unintentionally sending out emails that they are not supposed to send.

Cloudron assigns `location.app@domain` address by default to apps.
To change this email address, follow the instructions [here](/documentation/email/#changing-the-from-address-of-an-app).

