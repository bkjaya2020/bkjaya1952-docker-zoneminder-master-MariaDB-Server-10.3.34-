mysql -uroot -p < /usr/share/zoneminder/db/zm_create.sql
mysql -e "CREATE USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
dpkg-reconfigure tzdata
exit
