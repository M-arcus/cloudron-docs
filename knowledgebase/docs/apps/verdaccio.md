# <img src="/documentation/img/verdaccio-logo.png" width="25px"> Verdaccio App

## Custom configuration

You can add custom verdaccio configuration using the
[Web terminal](/documentation/apps#web-terminal):

* Add any custom configuration in `/app/data/config.yaml`.
* Restart the app

See [config.yaml](https://github.com/verdaccio/verdaccio/blob/master/conf/full.yaml) for
reference.

## Publishing packages

To publish a package:

```
npm adduser --registry https://<verdaccio domain>
npm publish --registry https://<verdaccio domain>
```

!!! warning "EPUBLISHCONFLICT"
    Verdaccio is a proxying package manager. Packages are checked against npmjs registry
    before being published. For this reason, publishing packages that already exist on npmjs
    will result in a `EPUBLISHCONFLICT` error. See [GitHub issue 1203](https://github.com/verdaccio/verdaccio/issues/1203)
    for a workaround.

## Installing packages

To set the custom registry globally:

```
npm adduser --registry https://<verdaccio domain>
npm set registry https://<verdaccio domain>
```

To set it on just the project:

```
npm adduser --registry https://<verdaccio domain>
npm install my-package --registry https://<verdaccio domain>
```

