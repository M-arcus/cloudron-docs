# User management

## Single Sign-On

Single Sign-on (SSO) is a feature of Cloudron where users can use the same credentials
(username & password) for logging in to apps.

SSO integration is optional and can be selected at the time of app installation. Turning off SSO
can be beneficial when the app is meant to be used primarily by external users (for example, a community
chat or a public forum).

Note that some apps do not support Cloudron SSO. Such apps manage their user credentials on their
own and users have to be managed inside the app itself.

When SSO is available for an app, the user management options will look like below:

<center>
<img src="../img/sso-available.png" class="shadow" width="600px">
</center>

When `Leave user management to the app` is selected, the app's Cloudron SSO integration will be disabled
and all user management has to be carried from within the app. This is useful when the app primarily caters
to external users (like say a community chat).

When SSO integration is unavailable for an app, the user management options look like below:

<center>
<img src="../img/sso-unavailable.png" class="shadow" width="600px">
</center>

## Users

New users can be invited to the Cloudron with their email address from the `Users` menu. They will receive
an invite to sign up. Once signed up, they can access the apps they have been given access to.

<center>
<img src="../img/user-list.png" class="shadow" width="600px">
</center>

To remove a user, simply remove them from the list. Note that the removed user cannot access any app anymore.

When Cloudron email is enabled, each user also get's a [mailbox](/documentation/email/#how-cloudron-email-works)
with their username.

## Groups

Groups provide a convenient way to group users. It's purpose is two-fold:

* You can assign one or more groups to apps to restrict who can access for an app.
* When Cloudron Email is enabled, each group is a [mailing list](/documentation/email/#creating-a-forwarding-mailbox)
  constituting of it's members.

You can create a group by using the `Groups` menu item.

<center>
<img src="../img/user-groups.png" class="shadow">
</center>

To set the access restriction use the app's configure dialog.

<center>
<img src="../img/app_access_control.png" class="shadow">
</center>

When Cloudron Email is enabled, mails can be sent to `groupname@<domain>` to address all the group members.

## Administrators

A Cloudron administrator is a special right given to an existing Cloudron user allowing them to manage
apps and users. To make another existing user an administator, click the edit (pencil) button corresponding to
the user and check the `Make this user a Cloudron admin` checkbox.

<center>
<img src="../img/user-admin.png" class="shadow" width="600px">
</center>

## Password reset

### Users

The password reset mechanism relies on email delivery working reliably. Users can reset their own passwords.

In the event that [email delivery is not working](/documentation/email/#debugging-mail-delivery), an administrator
can generate a new password reset link for another user by clicking on the 'Send invitation email' button.

<center>
<img src="../img/reinvite.png" class="shadow" width="600px">
</center>

This will open up a dialog showing the password reset link. If email delivery is not working for some
reason, the link can be sent to the user by some other means.

<center>
<img src="../img/invitation-dialog.png" class="shadow" width="600px">
</center>

### Admins

The password reset mechanism relies on email delivery working reliably. Admins can reset their own passwords
by navigating to `https://my.domain.com/api/v1/session/password/resetRequest.html`.

In the event that [email delivery is not working](/documentation/email/#debugging-mail-delivery), the reset token
can be determined by SSHing into the server:

```
mysql -uroot -ppassword -e "select username, resetToken from box.users";
```

Use the reset token displayed above to navigate to
`https://my.domain.com/api/v1/session/password/reset.html?reset_token=<token>`

