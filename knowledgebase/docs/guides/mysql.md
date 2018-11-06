
MySQL might sometimes refuse to start with INVALIDARGUMENT.

The idea now is to basically get mysql to start turning off it's auto-recovery.

* Stop box code: systemctl stop box

* Edit `/etc/mysql/my.cnf` to have
```
[mysqld]
innodb_force_recovery = 1
```

See https://dev.mysql.com/doc/refman/5.5/en/forcing-innodb-recovery.html

* Keep increasing the above value till mysql start with `systemctl start mysql`.

* Once it starts, we have to take a dump of all the database:
```
mysqldump -uroot -ppassword --skip-lock-tables -A > /root/alldb.sql
```

* systemctl stop mysql
* Remove the `innodb_force_recovery` in my.cnf
* my /var/lib/mysql /var/lib/mysql.old

* rm -rf /var/lib/mysql
* mkdir /var/lib/mysql
* chown -R mysql:mysql /var/lib/mysql
* mysqld --initialize
    * This will dump the password in /var/log/mysql/error.log
* systemctl start mysql
* mysql -uroot -p<password from log file>
    * Change the password `ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';`
* Import the database
    * mysql -uroot -ppassword < /root/alldb.sql

* systemctl restart cloudron.target

