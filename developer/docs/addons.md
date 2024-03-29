# Addons

## Overview

Addons are services like database, authentication, email, caching that are part of the
Cloudron runtime. Setup, provisioning, scaling and maintanence of addons is taken care of
by the platform.

The fundamental idea behind addons is to allow sharing of Cloudron resources across applications.
For example, a single MySQL server instance can be used across multiple apps. The Cloudron
platform sets up addons in such a way that apps are isolated from each other.

## Using Addons

Addons are opt-in and must be specified in the [Cloudron Manifest](/manifest).
When the app runs, environment variables contain the necessary information to access the addon.
For example, the mysql addon sets the `MYSQL_URL` environment variable which is the
connection string that can be used to connect to the database.

When working with addons, developers need to remember the following:

* Environment variables are subject to change every time the app restarts. This can happen if the
Cloudron is rebooted or restored or the app crashes or an addon is re-provisioned. For this reason,
applications must never cache the value of environment variables across restarts.

* Addons must be setup or updated on each application start up. Most applications use DB migration frameworks
for this purpose to setup and update the DB schema.

* Addons are configured in the [addons section](/manifest/#addons) of the manifest as below:

```
    {
      ...
      "addons": {
        "oauth": { },
        "redis" : { }
      }
    }
```

## All addons

### docker

This addon allows an app to create containers on behalf of the user.

Exported environment variables:

```
CLOUDRON_DOCKER_HOST=        # tcp://<IP>:<port>
```

Containers created by an application are tracked by Cloudron internally and will all get removed when
the app is uninstalled. In addition, all containers are forced to run in the `cloudron` internal network.

### email

This addon allows an app to send and recieve emails on behalf of the user. The intended use case is webmail applications.

If an app wants to send mail (e.g notifications), it must use the [sendmail](#sendmail)
addon. If the app wants to receive email (e.g user replying to notification), it must use the
[recvmail](#recvmail) addon instead.

Apps using the IMAP and ManageSieve services below must be prepared to accept self-signed certificates (this is not a problem
because these are addresses internal to the Cloudron).

Exported environment variables:

```
CLOUDRON_MAIL_SMTP_SERVER=       # SMTP server IP or hostname. Supports STARTTLS (TLS upgrade is enforced).
CLOUDRON_MAIL_SMTP_PORT=         # SMTP server port
CLOUDRON_MAIL_IMAP_SERVER=       # IMAP server IP or hostname. TLS required.
CLOUDRON_MAIL_IMAP_PORT=         # IMAP server port
CLOUDRON_MAIL_SIEVE_SERVER=      # ManageSieve server IP or hostname. TLS required.
CLOUDRON_MAIL_SIEVE_PORT=        # ManageSieve server port
CLOUDRON_MAIL_DOMAIN=            # Primary mail domain of the app
CLOUDRON_MAIL_DOMAINS=           # Comma separate list of domains handled by the server
```

### ldap

This addon provides LDAP based authentication via LDAP version 3.

Exported environment variables:

```
CLOUDRON_LDAP_SERVER=                                # ldap server IP
CLOUDRON_LDAP_PORT=                                  # ldap server port
CLOUDRON_LDAP_URL=                                   # ldap url of the form ldap://ip:port
CLOUDRON_LDAP_USERS_BASE_DN=                         # ldap users base dn of the form ou=users,dc=cloudron
CLOUDRON_LDAP_GROUPS_BASE_DN=                        # ldap groups base dn of the form ou=groups,dc=cloudron
CLOUDRON_LDAP_BIND_DN=                               # DN to perform LDAP requests
CLOUDRON_LDAP_BIND_PASSWORD=                         # Password to perform LDAP requests
```

The suggested LDAP filter is `(&(objectclass=user)(|(username=%uid)(mail=%uid)))`. This allows the user to login
via username or email.

For debugging, [cloudron exec](/cli/) can be used to run the `ldapsearch` client within the context of the app:

```
cloudron exec

# list users
> ldapsearch -x -h "${CLOUDRON_LDAP_SERVER}" -p "${CLOUDRON_LDAP_PORT}" -b  "${CLOUDRON_LDAP_USERS_BASE_DN}"

# list users with authentication (Substitute username and password below)
> ldapsearch -x -D cn=<username>,${CLOUDRON_LDAP_USERS_BASE_DN} -w <password> -h "${CLOUDRON_LDAP_SERVER}" -p "${CLOUDRON_LDAP_PORT}" -b  "${CLOUDRON_LDAP_USERS_BASE_DN}"

# list admins
> ldapsearch -x -h "${CLOUDRON_LDAP_SERVER}" -p "${CLOUDRON_LDAP_PORT}" -b  "${CLOUDRON_LDAP_USERS_BASE_DN}" "memberof=cn=admins,${CLOUDRON_LDAP_GROUPS_BASE_DN}"

# list groups
> ldapsearch -x -h "${CLOUDRON_LDAP_SERVER}" -p "${CLOUDRON_LDAP_PORT}" -b  "${CLOUDRON_LDAP_GROUPS_BASE_DN}"
```

The following attributes can be used from the LDAP response:

* `objectclass` - array that contains `user`
* `objectcategory` - set to 'person',
* `uid` - Unique identifier
* `cn` - Unique identifier (same as `uid`)
* `mail` - User's primary email
* `displayName` - Full name of the user
* `mailAlternateAddress` - Alternate/Fallback email address of the user (for password reset)
* `givenName` - First name of the user
* `sn` - Last name of the user
* `username` - Username set during account creation
* `samaccountname` - Same as username
* `isadmin` - Integer value set to 1 for admin users
* `memberof` - List of Cloudron groups the user is a memer of

### localstorage

Since all Cloudron apps run within a read-only filesystem, this addon provides a writeable folder under `/app/data/`.
All contents in that folder are included in the backup. On first run, this folder will be empty. File added in this path
as part of the app's image (Dockerfile) won't be present. A common pattern is to create the directory structure required
the app as part of the app's startup script.

The permissions and ownership of data within that directory are not guranteed to be preserved. For this reason, each app
has to restore permissions as required by the app as part of the app's startup script.

If the app is running under the recommeneded `cloudron` user, this can be achieved with:

```
chown -R cloudron:cloudron /app/data
```

### mongodb

By default, this addon provide MongoDB 3.6.3.

Exported environment variables:

```
CLOUDRON_MONGODB_URL=          # mongodb url
CLOUDRON_MONGODB_USERNAME=     # username
CLOUDRON_MONGODB_PASSWORD=     # password
CLOUDRON_MONGODB_HOST=         # server IP/hostname
CLOUDRON_MONGODB_PORT=         # server port
CLOUDRON_MONGODB_DATABASE=     # database name
CLOUDRON_MONGODB_OPLOG_URL=    # oplog access URL (see below)
```

App can request oplog access by setting the `oplog` option to be true.

```
"mongodb": { "oplog": true }
```

For debugging, [cloudron exec](/cli/) can be used to run the `mongo` shell within the context of the app:

```
cloudron exec

# mongo -u "${CLOUDRON_MONGODB_USERNAME}" -p "${CLOUDRON_MONGODB_PASSWORD}" ${CLOUDRON_MONGODB_HOST}:${CLOUDRON_MONGODB_PORT}/${CLOUDRON_MONGODB_DATABASE}

```
### mysql

By default, this addon provides a single database on MySQL 5.7.23. The database is already created and the application
only needs to create the tables.

Exported environment variables:

```
CLOUDRON_MYSQL_URL=            # the mysql url (only set when using a single database, see below)
CLOUDRON_MYSQL_USERNAME=       # username
CLOUDRON_MYSQL_PASSWORD=       # password
CLOUDRON_MYSQL_HOST=           # server IP/hostname
CLOUDRON_MYSQL_PORT=           # server port
CLOUDRON_MYSQL_DATABASE=       # database name (only set when using a single database, see below)
```

For debugging, [cloudron exec](/cli/) can be used to run the `mysql` client within the context of the app:

```
cloudron exec

> mysql --user=${CLOUDRON_MYSQL_USERNAME} --password=${CLOUDRON_MYSQL_PASSWORD} --host=${CLOUDRON_MYSQL_HOST} ${CLOUDRON_MYSQL_DATABASE}

```

The `multipleDatabases` option can be set to `true` if the app requires more than one database.
When enabled, the following environment variables are injected and the `MYSQL_DATABASE` is removed:

```
CLUODRON_MYSQL_DATABASE_PREFIX=      # prefix to use to create databases
```

All the databases use `utf8mb4` encoding by default.

```
mysql> SELECT @@character_set_database, @@collation_database;
+--------------------------+----------------------+
| @@character_set_database | @@collation_database |
+--------------------------+----------------------+
| utf8mb4                  | utf8mb4_unicode_ci   |
+--------------------------+----------------------+
```

To see the charset of a table: `SHOW CREATE TABLE <tablename>`.  Columns can have a collation order
of their own which can seen using `SHOW TABLE STATUS LIKE <tablename>`.

### oauth

The Cloudron OAuth 2.0 provider can be used in an app to implement Single Sign-On.

Exported environment variables:

```
CLOUDRON_OAUTH_CLIENT_ID=      # client id
CLOUDRON_OAUTH_CLIENT_SECRET=  # client secret
```

The callback url required for the OAuth transaction can be contructed from the environment variables below:

```
CLOUDRON_APP_DOMAIN=           # hostname of the app
CLOUDRON_APP_ORIGIN=           # origin of the app of the form https://domain
CLOUDRON_API_ORIGIN=           # origin of the OAuth provider of the form https://my.domain
```

OAuth2 URLs can be constructed as follows:

```
AuthorizationURL = ${CLOUDRON_API_ORIGIN}/api/v1/oauth/dialog/authorize # see above for API_ORIGIN
TokenURL = ${CLOUDRON_API_ORIGIN}/api/v1/oauth/token
LogoutURL = ${CLOUDRON_API_ORIGIN}/api/v1/session/logout?redirect=<callback url>
```

The token obtained via OAuth has a restricted scope wherein they can only access the [profile API](/api/#profile). This restriction
is so that apps cannot make undesired changes to the user's Cloudron.

The access token can be provided either via the request query `?access_token=<token>` or in the `Authorization` header using `Bearer <token>`.

We currently provide OAuth2 integration for Ruby [omniauth](https://git.cloudron.io/cloudron/omniauth-cloudron) and Node.js [passport](https://git.cloudron.io/cloudron/passport-cloudron).

### postgresql

By default, this addon provides PostgreSQL 10.5

Exported environment variables:

```
CLOUDRON_POSTGRESQL_URL=       # the postgresql url
CLOUDRON_POSTGRESQL_USERNAME=  # username
CLOUDRON_POSTGRESQL_PASSWORD=  # password
CLOUDRON_POSTGRESQL_HOST=      # server name
CLOUDRON_POSTGRESQL_PORT=      # server port
CLOUDRON_POSTGRESQL_DATABASE=  # database name
```

The postgresql addon whitelists the hstore and pg\_trgm extensions to be installable by the database owner.

For debugging, [cloudron exec](/cli/) can be used to run the `psql` client within the context of the app:

```
cloudron exec

> PGPASSWORD=${CLOUDRON_POSTGRESQL_PASSWORD} psql -h ${CLOUDRON_POSTGRESQL_HOST} -p ${CLOUDRON_POSTGRESQL_PORT} -U ${CLOUDRON_POSTGRESQL_USERNAME} -d ${CLOUDRON_POSTGRESQL_DATABASE}
```

### recvmail

The recvmail addon can be used to receive email for the application.

Exported environment variables:

```
CLOUDRON_MAIL_IMAP_SERVER=     # the IMAP server. this can be an IP or DNS name
CLOUDRON_MAIL_IMAP_PORT=       # the IMAP server port
CLOUDRON_MAIL_IMAP_USERNAME=   # the username to use for authentication
CLOUDRON_MAIL_IMAP_PASSWORD=   # the password to use for authentication
CLOUDRON_MAIL_TO=              # the "To" address to use
CLOUDRON_MAIL_DOMAIN=          # the mail for which email will be received
```

The IMAP server only accepts TLS connections. The app must be prepared to accept self-signed certs (this is not a problem because the
imap address is internal to the Cloudron).

For debugging, [cloudron exec](https://www.npmjs.com/package/cloudron) can be used to run the `openssl` tool within the context of the app:

```
cloudron exec

> openssl s_client -connect "${CLOUDRON_MAIL_IMAP_SERVER}:${CLOUDRON_MAIL_IMAP_PORT}" -crlf
```

The IMAP command `? LOGIN username password` can then be used to test the authentication.

### redis

By default, this addon provides redis 4.0.9. The redis is configured to be persistent and data is preserved across updates
and restarts.

Exported environment variables:

```
CLOUDRON_REDIS_URL=            # the redis url
CLOUDRON_REDIS_HOST=           # server name
CLOUDRON_REDIS_PORT=           # server port
CLOUDRON_REDIS_PASSWORD=       # password
```

For debugging, [cloudron exec](/cli/) can be used to run the `redis-cli` client within the context of the app:

```
cloudron exec

> redis-cli -h "${CLOUDRON_REDIS_HOST}" -p "${CLOUDRON_REDIS_PORT}" -a "${CLOUDRON_REDIS_PASSWORD}"
```

### scheduler

The scheduler addon can be used to run tasks at periodic intervals (cron).

Scheduler can be configured as below:

```
    "scheduler": {
        "update_feeds": {
            "schedule": "*/5 * * * *",
            "command": "/app/code/update_feed.sh"
        }
    }
```

In the above example, `update_feeds` is the name of the task and is an arbitrary string.

`schedule` values must fall within the following ranges:

 * Minutes: 0-59
 * Hours: 0-23
 * Day of Month: 1-31
 * Months: 0-11
 * Day of Week: 0-6

_NOTE_: scheduler does not support seconds

`schedule` supports ranges (like standard cron):

 * Asterisk. E.g. *
 * Ranges. E.g. 1-3,5
 * Steps. E.g. \*/2

`command` is executed through a shell (sh -c). The command runs in the same launch environment
as the application. Environment variables, volumes (`/tmp` and `/run`) are all
shared with the main application.

Tasks are given a grace period of 30 minutes to complete. If a task is still running after 30 minutes
and a new instance of the task is scheduled to be started, the previous task instance is killed.

### sendmail

The sendmail addon can be used to send email from the application.

Exported environment variables:

```
CLOUDRON_MAIL_SMTP_SERVER=     # the mail server (relay) that apps can use. this can be an IP or DNS name
CLOUDRON_MAIL_SMTP_PORT=       # the mail server port. Currently, this port disables TLS and STARTTLS.
CLOUDRON_MAIL_SMTPS_PORT=      # SMTPS server port.
CLOUDRON_MAIL_SMTP_USERNAME=   # the username to use for authentication
CLOUDRON_MAIL_SMTP_PASSWORD=   # the password to use for authentication
CLOUDRON_MAIL_FROM=            # the "From" address to use
CLOUDRON_MAIL_DOMAIN=          # the domain name to use for email sending (i.e username@domain)
```

The SMTP server does not require STARTTLS. If STARTTLS is used, the app must be prepared to accept self-signed certs.

For debugging, [cloudron exec](/cli/) can be used to run the `swaks` tool within the context of the app:

```
cloudron exec

> swaks --server "${CLOUDRON_MAIL_SMTP_SERVER}" -p "${CLOUDRON_MAIL_SMTP_PORT}" --from "${CLOUDRON_MAIL_FROM}" --body "Test mail from cloudron app at $(hostname -f)" --auth-user "${CLOUDRON_MAIL_SMTP_USERNAME}" --auth-password "${CLOUDRON_MAIL_SMTP_PASSWORD}"


> swaks --server "${CLOUDRON_MAIL_SMTP_SERVER}" -p "${CLOUDRON_MAIL_SMTPS_PORT}" --from "${CLOUDRON_MAIL_FROM}" --body "Test mail from cloudron app at $(hostname -f)" --auth-user "${CLOUDRON_MAIL_SMTP_USERNAME}" --auth-password "${CLOUDRON_MAIL_SMTP_PASSWORD}" -tlsc
```

