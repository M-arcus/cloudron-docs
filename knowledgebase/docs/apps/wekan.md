# <img src="/documentation/img/wekan-logo.png" width="25px"> Wekan App

## API

Wekan has a [REST API](https://github.com/wekan/wekan/wiki/REST-API) for
managing users.

## Webbooks

When a webhook is activated, Wekan sends the related information within the POST request body.
See [Webhook-data](https://github.com/wekan/wekan/wiki/Webhook-data) for details.

## Users

Wekan currently does not support syncing or searching users via LDAP. This limitation means
that a user must login to Wekan first before they become available for sharing
boards.

