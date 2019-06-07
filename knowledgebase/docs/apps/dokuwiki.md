# <img src="/documentation/img/dokuwiki-logo.png" width="25px"> Dokuwiki App

## User management

### Cloudron SSO

When Cloudron SSO is enabled, only Cloudron users can login to the wiki and
edit pages. 

To make a Cloudron user an admin, use the [Web terminal](/documentation//documentation/apps#web-terminal)
and edit `/app/data/conf/local.php`:

```
<?php

$conf['superuser']   = ("userid1", "userid2");
```

To make all Cloudron admins as wiki admins edit `/app/data/conf/local.php` and add:

```
<?php

$conf['plugin']['authldap']['mapping']['grps']  = array('memberof' => '/CN=(.+?),/i');
$conf['superuser']   = '@admins';
```

By default, the pages are readable by all. The wiki can be made readable
only for logged in users by changing the ACL Rules for the `@ALL` group
in dokuwiki's `Access Control List Management` admin page.

### Without Cloudron SSO

When not using Cloudron authentication, first register a new user.

To make the new user an admin, use the [Web terminal](/documentation//documentation/apps#web-terminal)
and edit `/app/data/conf/local.php`:

```
<?php

$conf['superuser']   = ("userid1", "userid2");
```

#### Disabling registration

To [disable registration](https://www.dokuwiki.org/faq:regdisable), `Admin` -> `Configuration Manager` -> `Disable DokuWiki actions`
and check `Register`.

## Configuring

At a high level, Dokuwiki applies [configuration](https://www.dokuwiki.org/config) as follows:

* `conf/foo.conf` – default value that comes with Dokuwiki. **Do not make changes to these files, they will be lost across updates.**
* `conf/foo.protected.conf` – settings applied by the Cloudron package. **Do not make changes to these files, they will be lost across updates.**
* `conf/foo.local.conf` – changed by plugin manager or Cloudron user. Changes can be freely made to these files and they will be retained across updates.

## Plugins

[Plugins](https://www.dokuwiki.org/plugins) can be installed using the `Extension Manager`.

Some [suggested](http://diyfuturism.com/index.php/2018/01/01/how-to-set-up-a-personal-wiki-with-configuration-for-common-use-cases-like-recipes-and-journaling/) plugins:

* Blockquote – Easily add blockquoted text
* Blog – displays your posts in a familiar blog format
* Todo – add todo’s to wiki pages and assign to users if desired
* Dokubookmark – archive web pages with a simple bookmarklet to your wiki
* DW2PDF – Export wiki pages as PDFs
* EditTable – Visually edit and add tables
* Gallery – Embed image galleries in pages
* Move – move pages and namespaces while preserving all links
* Note – Insert notes that stand out from the rest of your text. Useful for documentation.
* NSPages – Automatically generate a custom list of pages in your wiki or namespace
* TemplatePageName – Changes the default template names so they can be edited from within the wiki.
* Struct – Index, display, and query structured data in your wiki pages (requires SQLite)
* Tag – add tagging functions
* VShare – Embed videos
* Wrap – probably the most useful formatting plugin – easily add columns, notes, divs, etc.
* Yearbox – Auto generate a table with links for a journal or diary, very customizable.

## Themes

[Themes (templates)](https://www.dokuwiki.org/template) can be installed using the `Extension Manager`.
Note that the theme has to be activated after installation. This can be done using the `Configuration Manager`'s
`template` drop down setting.

