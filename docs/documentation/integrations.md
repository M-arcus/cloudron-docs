# Cloudron REST API

## Integrating with Zapier

Cloudron REST API can be used as part of a Zapier or IFTTT workflow.

Note that the Zapier `POST action` automatically coerces all values to strings. This means that values
like `null` automatically become the string `"null"`.

To workaround this, use the `Custom Request action` instead of the `POST action`.

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

## OAuth Provider

Cloudron is an OAuth 2.0 provider. To integrate Cloudron login into an external application, create
an OAuth application under `API Access`.

You can use the following OAuth URLs to add Cloudron in the external app:
```
authorizationURL: https://my.<domain>/api/v1/oauth/dialog/authorize

tokenURL:         https://my.<domain>/api/v1/oauth/token
```

