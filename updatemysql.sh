#!/bin/bash
mysql -e "drop database zm;"
mysql -uroot --password=""< /usr/share/zoneminder/db/zm_create.sql 2>/dev/null
mysql -e "ALTER USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
exit
