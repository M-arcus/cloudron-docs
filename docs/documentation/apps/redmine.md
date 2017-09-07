## Installing plugins

To install plugins in redmine, simply extract them to `/app/data/plugins`
and run the db migration.

* Open a [web terminal](/documentation/apps/#modifying-files-of-an-app)
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

