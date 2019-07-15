# <img src="/documentation/img/discourse-logo.png" width="25px"> Discourse App

## Changing domain

When changing the domain of an existing discourse installation, Cloudron automatically
rebuilds the assets. However, the posts in the forum are not re-written. To rebake
the posts, open a [Web terminal](/documentation/apps#web-terminal) and run the following
command:

```
    sudo -E -u cloudron bundle exec ruby script/discourse remap old.domain.com new.domain.com
```

## Rebaking posts

To rebuild all posts (for example, to apply formatting provided by a newly installed plugin to
old posts), open a [Web terminal](/documentation/apps#web-terminal) and run the following
command:

```
    sudo -E -u cloudron bundle exec rake posts:rebake
```
