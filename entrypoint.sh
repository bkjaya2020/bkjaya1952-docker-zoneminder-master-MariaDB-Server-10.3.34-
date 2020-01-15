#!/bin/bash

service mysql start
 mysql
CREATE USER 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY '';
GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES ;
quit
/etc/init.d/mysql restart
mysql
CREATE USER 'zmuser'@localhost IDENTIFIED WITH mysql_native_password BY 'zmpass';
GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES ;
quit
mysqladmin -uroot -p reload
systemctl enable zoneminder
/etc/init.d/zoneminder start
/etc/init.d/apache2 restart

tail -F n0 /dev/null
