# <img src="/documentation/img/redmine-logo.png" width="25px"> Redmine App

## Installing plugins

To install plugins in redmine, simply extract them to `/app/data/plugins`
and run the db migration.

* Open a [web terminal](/documentation/apps#web-terminal)
for the app.
* Upload the plugin .zip (if any) to `/tmp` using the upload button
and extract the plugin to `/app/data/plugins`

```
# unzip /tmp/redmine_checklists-3_1_7-light.zip -d /app/data/plugins
```

* Some plugins require gems to be installed but for some reason do not have
`source 'https://rubygems.org'` at the start of the Gemfile. If it is missing,
add the line to the top of Gemfile

```
cd /app/data/plugins/redmine_contacts
vi Gemfile                  # ensure first line is "source 'https://rubygems.org'"
bundle install              # this installs gems into /app/data/bundle/vendor
```

* Initialize the database of the plugin

```
# cd /app/code
# bundle exec rake redmine:plugins NAME=redmine_checklists RAILS_ENV=production
```

* Restart redmine using the `restart` button

## Installing themes

To install plugins in redmine, simply extract them to `/app/data/themes`,
install dependancies and run the build script

```
cd /app/data/themes/
git clone https://github.com/hardpixel/minelab.git
cd minelab
bundle install
./bundle.sh
```

## Code repositories

Redmine can integrate various source code management tools like git, cvs, subversion. The repositories
have to be created manually in `/app/data/repos/` and then configured with that path in the project settings.

For further more detailed information for repository integration can be found [here](http://www.redmine.org/projects/redmine/wiki/RedmineRepositories).

