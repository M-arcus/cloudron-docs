# <img src="/documentation/img/surfer-logo.png" width="25px"> Surfer App

Surfer comes with a webinterface to manage and upload files, a command line tool as well as providing a [WebDAV](https://en.wikipedia.org/wiki/WebDAV) endpoint to manage files in your local file manager.

The web interface is available under the `https://[appdomain]/_admin/` location.

## CLI tool

Install the surfer cli tool using npm.

```
    npm -g install cloudron-surfer
```

Login using your Cloudron credentials:

```
    surfer login <this app's domain>
```

Put some files:

```
    surfer put [file]
```

## WebDAV

WebDAV is a well supported extension of the Hypertext Transfer Protocol that allows clients to perform remote Web content authoring operations. WebDAV shares can be mounted usually with your local file manager.

The URI schemes differ on the common platforms:

| Platform| URI |
| ---     | --- |
| Windows | https://[appdomain]/_webdav/ |
| Mac     | https://[appdomain]/_webdav/ |
| Gnome   | davs://[appdomain]/_webdav/ |
| KDE     | webdavs://[appdomain]/_webdav/ |

On Linux the [Davfs2](http://savannah.nongnu.org/projects/davfs2) library can also be used to locally mount a share:
```
mount -t davfs https://[appdomain]/_webdav/ /mount/point
```

### Using SFTP

The app can be uploaded using an SFTP client like [FileZilla](https://filezilla-project.org/).

You can find the SFTP login details when clicking on the `i` icon in the app grid.

<center>
<img src="/documentation/img/lamp-filezilla.png" class="shadow">
</center>


