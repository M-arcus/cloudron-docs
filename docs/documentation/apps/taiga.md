## Importing a project

* Connect to taiga using the Webterminal
* Upload the project.json using the 'Upload to /tmp' button
* `su cloudron`
* `source /app/code/taiga/bin/activate`
* `cd /app/code/taiga-back`
* `python manage.py load_dump /tmp/project.json email@domain.tld`

