# <img src="/documentation/img/mediawiki-logo.png" width="25px"> MediaWiki App

## Access Control

### Default setup

When using Cloudron SSO, the wiki is setup to be editable only by Cloudron users.
Anonymous users can read all pages. Cloudron admins are added into the 'admins'
mediawiki group. This group is given `bureaucrat` permission. Please note that
when using this option, external registration [cannot be enabled](https://stackoverflow.com/questions/46403601/mediawiki-its-not-possible-to-create-user-account-using-ldap-authentication-ex).

When not using Cloudron SSO, the wiki is setup to be editable by users with a
registered wiki account.

### Changing permissions

Use the [Web terminal](/documentation/apps#web-terminal) to edit the values in
`/app/data/LocalSettings.php`.

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

To set a custom icon, use the [Web terminal](/documentation/apps#web-terminal):

* Upload a file to '/tmp'
* In the web terminal, move the uploaded file to `/app/data/images/wiki.png`.

## Extensions

### Installing

MediaWiki [https://www.mediawiki.org/wiki/Manual:Extensions](extensions) can be installed
as follows:

* Use the [Web terminal](/documentation/apps#web-terminal) to upload the tarball to `/tmp`
* Extract the package under `/app/data/extensions` and run `chown -R www-data:www-data /app/data/extensions`
* Load the skin in `/app/data/LocalSettings.php` by adding this line:
```
        wfLoadExtension( '<extension-name>' );
```
* Additional extension settings may be set in `/app/data/LocalSettings.php`

### Suppressing skins

To [suppress](https://www.mediawiki.org/wiki/Manual:Skin_configuration) one or more skins add the following line
to `/app/data/LocalSettings.php`:

```
    $wgSkipSkins = array( "cologneblue", "monobook" );
```

## Skins

### Installing

MediaWiki [https://www.mediawiki.org/wiki/Manual:Gallery_of_user_styles](skins) can be installed
as follows:

* Use the [Web terminal](/documentation/apps#web-terminal) to upload the tarball to `/tmp`
* Extract the package under `/app/data/skins` and run `chown -R www-data:www-data /app/data/skins`
* Load the skin in `/app/data/LocalSettings.php` by adding this line:
```
        wfLoadSkin( '<skin-name>' );
```
* The default skin for new users can be changed by adding this line to `/app/data/LocalSettings.php`:
```
        $wgDefaultSkin = '<skin-name>';
```

### Suppressing skins

To [suppress](https://www.mediawiki.org/wiki/Manual:Skin_configuration) one or more skins add the following line
to `/app/data/LocalSettings.php`:

```
    $wgSkipSkins = array( "cologneblue", "monobook" );
```

