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
<img src="/documentation/img/sso-available.png" class="shadow" width="500px">
</center>

When `Leave user management to the app` is selected, the app's Cloudron SSO integration will be disabled
and all user management has to be carried from within the app. This is useful when the app primarily caters
to external users (like say a community chat).

When SSO integration is unavailable for an app, the user management options look like below:

<center>
<img src="/documentation/img/sso-unavailable.png" class="shadow" width="500px">
</center>

## Users

New users can be added to the Cloudron with their email address from the `Users` menu.

<center>
<img src="/documentation/img/user-list.png" class="shadow" width="500px">
</center>

Click on `New User` to add a new user:

<center>
<img src="/documentation/img/users-add.png" class="shadow" width="500px">
</center>

They will receive an invite to sign up. Once signed up, they can access the apps they have been given access to.

To remove a user, simply remove them from the list. Note that the removed user cannot access any app anymore.

## Groups

Groups provide a convenient way to group users. You can assign one or more groups to apps to restrict who can
access for an app.

You can create a group by using the `Groups` menu item.

<center>
<img src="/documentation/img/users-groups-list.png" class="shadow">
</center>

Click on `New Group` to add a new group:

<center>
<img src="/documentation/img/users-groups-add.png" class="shadow">
</center>


To set the access restriction use the app's configure dialog.

<center>
<img src="/documentation/img/app-configure-group-acl.png" class="shadow" width="500px">
</center>

## Administrators

A Cloudron administrator is a special right given to an existing Cloudron user allowing them to manage
apps and users. To make another existing user an administator, click the edit (pencil) button corresponding to
the user and check the `Make this user a Cloudron admin` checkbox.

<center>
<img src="/documentation/img/user-admin.png" class="shadow" width="500px">
</center>

## Password reset

### Users

The password reset mechanism relies on email delivery working reliably. Users can reset their own passwords.

In the event that [email delivery is not working](email/#debugging-mail-delivery), an administrator
can generate a new password reset link for another user by clicking on the 'Send invitation email' button.

<center>
<img src="/documentation/img/reinvite.png" class="shadow" width="500px">
</center>

This will open up a dialog showing the password reset link. If email delivery is not working for some
reason, the link can be sent to the user by some other means.

<center>
<img src="/documentation/img/invitation-dialog.png" class="shadow" width="500px">
</center>

### Admins

The password reset mechanism relies on email delivery working reliably. Admins can reset their own passwords
by navigating to `https://my.example.com/api/v1/session/password/resetRequest.html`.

In the event that [email delivery is not working](email/#debugging-mail-delivery), the reset token
can be determined by SSHing into the server:

```
mysql -uroot -ppassword -e "select username, resetToken from box.users";
```

Use the reset token displayed above to navigate to
`https://my.example.com/api/v1/session/password/reset.html?reset_token=<token>`

## Disabling 2FA

If a user loses their 2FA device, the Cloudron administrator can disable the user's
2FA setup by SSHing into the server and running the following command:

```
# replace fred below with the actual username
root@my:~# mysql -uroot -ppassword -e "UPDATE box.users SET twoFactorAuthenticationEnabled=false WHERE username='fred'"
mysql: [Warning] Using a password on the command line interface can be insecure.
```

Once disabled, user can login with just their password. After login, they can
re-setup 2FA.

## Valid usernames

The following characters are allowed in usernames:

* Alphanumeric characters
* '.' (dot)
* '-' (hyphen)

Usernames must be chosen with care to accomodate the wide variety of apps that run on Cloudron.
For example, very generic words like `error`, `pull`, `404` might be reserved by apps.

