# <img src="/img/phabricator-logo.png" width="25px"> Phabricator App

## Completing the installation

To complete the installation, setup an administrative account and setup
an Auth provider.

If you accidentally log yourself out before adding an Auth provider, you
must use the CLI tool to recover it (or simply re-install phabricator).
See [T8282](https://secure.phabricator.com/T8282) for more information.

You can add users using the 'People' section on the Homepage. See the
[https://secure.phabricator.com/book/phabricator/article/configuring_accounts_and_registration/](configuring docs)
for more information.

## Uploading large files

This app is configured to accept files upto 512MB. Note that large files need to be
dragged and dropped (instead of the file upload button).

See [Q216](https://secure.phabricator.com/Q216)

