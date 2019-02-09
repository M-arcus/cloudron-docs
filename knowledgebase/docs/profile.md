# Profile

## Account settings

A user in the Cloudron has the following fields as part of their profile:

<center>
<img src="/documentation/img/profile-account.png" class="shadow" width="500px">
</center>

* `username` - The username cannot be changed. To change the username, delete the old
  username and create a new one instead.

* `Display name` - This contains the first name and last name of the user.

* `Primary email` - This is the email that is provided to apps. Apps may send notifications
  to the user to this email address. This can be set to an email address hosted on the Cloudron.

* `Password recover email` - This is the email to which Cloudron password resets are sent. This
  should be set to an email address that is not hosted on the Cloudron.

## Enabling 2FA

2FA can be enabled using the `Enable 2FA button` from the `profile` view in the dashboard.

Clicking on the button will display a QR Code which can be scanned
using a TOTP app such as Google Authenticator ([Android](https://play.google.com/store/apps/details?id=com.google.android.apps.authenticator2),
[iOS](https://itunes.apple.com/us/app/google-authenticator/id388497605)),
FreeOTP authenticator ([Android](https://play.google.com/store/apps/details?id=org.fedorahosted.freeotp),
[iOS](https://itunes.apple.com/us/app/freeotp-authenticator/id872559395]))

<br/>

<center>
<img src="/blog/img/profile-qrcode.png" width="500px" class="shadow">
</center>

## Disabling 2FA

Users can disable 2FA by clicking on the `Disable 2FA button`. In the event, the user
loses their 2FA device, a Cloudron administrator can [reset it](/documentation/user-management/#disabling-2fa).

