add-apt-repository ppa:iconnor/zoneminder-1.34 
apt -y install zoneminder 
/etc/init.d/mysql start
cp zm_create.sql /usr/share/zoneminder/db/zm_create.sql
mysql -uroot --password=""< /usr/share/zoneminder/db/zm_create.sql 2>/dev/null
mysql -e "ALTER USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
mysqladmin -uroot --password="" reload 2>/dev/null
