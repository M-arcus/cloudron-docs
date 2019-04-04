# <img src="/documentation/img/commento-logo.png" width="25px"> Commento App

Commento is a fast, privacy-focused commenting platform.

## Usermanagement

Commento does not integrate with Cloudron usermanagement but instead has two types of users.

1. **Owners** which can manage domains where comments may be shown as well as act as moderators.
2. **Commentors** which have to be created by every user wanting to write a comment

Owner signup is enabled by default and can be done when visiting the domain where a Commento instance is installed at.
To disable open owner registration, to change this, edit `/app/data/commento.conf`
```
COMMENTO_FORBID_NEW_OWNERS=true
```

## Sign-in with Google

Commento also supports OAuth sign-in with Google for users wanting to comment.
To enable this feature, create a Google API secret and key pair and put those into `/app/data/commento.conf`
```
COMMENTO_GOOGLE_KEY=<your key>
COMMENTO_GOOGLE_SECRET=<your secret>
```
