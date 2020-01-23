#!/bin/bash
service mysql start
mysql

CREATE USER 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY '';

GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES ; 

CREATE USER 'zmuser'@localhost IDENTIFIED WITH mysql_native_password BY 'zmpass';

GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES ;

quit 
systemctl enable zoneminder
/usr/bin/zmpkg.pl start
/etc/init.d/apache2 start
tail -F n0 /dev/null
