#!/bin/bash
/etc/init.d/mysql start
mysql -e "drop database zm;"
mysql -uroot --password=""< /usr/share/zoneminder/db/zm_create.sql 2>/dev/null
mysql -e "ALTER USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
/etc/init.d/apache2 start
chmod 777 /var/run/zm
/usr/bin/zmpkg.pl start
