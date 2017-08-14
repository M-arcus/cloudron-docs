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

## OAuth 2.0 Login Provider

Cloudron is an OAuth 2.0 provider. To integrate Cloudron login into an external application, create
an OAuth application under `API Access`.

<center>
<img src="/img/add-oauth-client.png" class="shadow" width="600px">
</center>

The dialog requires 3 parameters:

*   The `Application Name` is the name of the external application. Set this
    to something memorable.

*   `Authorization Callback URL` is the URL that the Cloudron will callback
    after authentication.

*   Once authenticated, `Scope` specifies the resources to which the application
    has access. The `profile` scope indicates that the app only gets access to
    the user's profile and nothing else.

<br/>
<center>
<img src="/img/oauth-tokens.png" class="shadow" height="300px">
</center>
<br/>

You can use the following OAuth URLs to add Cloudron in the external app:
```
authorizationURL: https://my.<domain>/api/v1/oauth/dialog/authorize

tokenURL:         https://my.<domain>/api/v1/oauth/token
```

Read this [blog post](https://cloudron.io/blog/2017-03-21-oauth-provider.html) for
a demonstration.


