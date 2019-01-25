# <img src="/documentation/img/githubpages-logo.png" width="25px"> GitHub Pages App

## Publishing pages

To publish your page, push your GitHub Pages repository via HTTP to this
app:

```
    git remote add page https://<app.example.com>/_git/page
    git push page master
```

When pushing, `git` will prompt for Cloudron username and credentials. Any
Cloudron user with access to the app can push.

It can be convenient to store the HTTP username and password in the `~/.netrc`
file:

```
    machine app.example.com login fred password bluebonnet
```

Adjust `app.example.com`, `fred` and `bluebonnet` above to your setup.

## Jekyll plugins

The GitHub pages app does not support custom Jekyll plugins. The app follows
the list of plugins supported by GitHub pages. See
[GitHub pages plugins](https://pages.github.com/versions/) page for a list of
supported plugins.

## GitHub pages GEM

The app uses the [pages gem](https://github.com/github/pages-gem) to statically
build the website. In the event that the gem update does not build the repo (because
of version mismatch), the app will continue to serve the last successful build.

## Using mkdocs

[mkdocs](https://www.mkdocs.org/) has a command called `gh-deploy` that can
automatically build docs and publish the site to a specific remote and branch.

```
    git remote add page https://site.cloudron.xyz/_git/page # add the github-pages app remote
    mkdocs gh-deploy --remote-name page --remote-branch master --force
```

