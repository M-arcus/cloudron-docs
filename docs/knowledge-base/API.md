# Cloudron REST API

## What is the Cloudron REST API

The Cloudron provides a complete [RESTful API](/references/API/) to manage all
aspects of the Cloudron like adding users, configuring groups and installing apps.

## Using the Cloudron REST API

The [Cloudron API](/references/API/) is available at the `my` subdomain of your Cloudron. To access
the API, you need an access token. The Cloudron can create an access token from
the `API Access` page.

<img src="/img/access-token2.png" class="shadow">

The access token can be provided via the request query `?access_token=<token>`.

```
curl -H "Content-Type: application/json" https://my.cloudron/api/v1/users?access_token=$TOKEN
```

Alternately, the token can be provided via the Authorization header using `Bearer <token>`.
```
curl -H "Content-Type: application/json" -H "Authorization: Bearer <token>" https://my.cloudron/api/v1/users
```

## Integrating with Zapier

Cloudron REST API can be used as part of a Zapier or IFTTT workflow.

Note that the Zapier POST action automatically coerces all values to strings. To workaround this,
use the Custom Request action instead of the POST action.

Here's an example that works on the Cloudron:
```
Method
POST
URL
https://my-demo.cloudron.me/api/v1/apps/install?access_token=c39f3a533798e3450e7b49ec24ff4e40898d4ddf23f409e40ae721491624ccf5
Data
{ "location": "blog", "appStoreId": "org.wordpress.cloudronapp", "accessRestriction": null }
Unflatten
yes
Headers
application/json
Optional fields without a value
Data Pass-Through?
Basic Auth
```

