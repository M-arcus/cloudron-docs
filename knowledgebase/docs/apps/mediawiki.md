# <img src="../img/mediawiki-logo.png" width="25px"> MediaWiki App

## Access Control

### Default setup

When using Cloudron SSO, the wiki is setup to be editable only by Cloudron users.
Anonymous users can read all pages. Cloudron admins are added into the 'admins'
mediawiki group. This group is given `bureaucrat` permission.

When not using Cloudron SSO, the wiki is setup to be editable by users with a
registered wiki account.

### Changing permissions

Use the [Web terminal](/documentation/apps/#web-terminal) to edit the values in
`/app/data/AccessControl.php`.

Here are some commonly requested settings:

* To disable read access for anonymous users, add the following line:

    $wgGroupPermissions['*']['read'] = false;

* To allow write access to anonymous users, add the following line:

    $wgGroupPermissions['*']['edit'] = true;

* To disable email confirmation before new users are allowed to edit files:

    $wgEmailConfirmToEdit = false;

* To disallow account creation and remove the 'Create account' link:

    $wgGroupPermissions['*']['createaccount'] = false;

## Administrator operations

MediaWiki has 3 built-in groups: bots, bureaucrats and sysop. sysops are administrators that have
[special previliges](https://www.mediawiki.org/wiki/Help:Sysops_and_permissions):

* Protecting and unprotecting pages, and editing protected pages
* Deleting pages, and undeleting
* Blocking a user or IP address, and unblocking them.

Bureaucrats are sysops with the additional role of being able to **promote users to be sysops**.

Sysops can perform a number of maintanence operations by vising `/wiki/Special:SpecialPages` of the wiki.

### Setting a custom icon

To set a custom icon, use the [Web terminal](/documentation/apps/#web-terminal):

* Upload a file to '/tmp'
* In the web terminal, move the uploaded file to `/app/data/images/wiki.png`.

