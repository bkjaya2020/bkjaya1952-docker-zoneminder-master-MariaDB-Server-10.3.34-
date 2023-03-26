add-apt-repository ppa:iconnor/zoneminder
apt -y install mariadb-server
apt -y install zoneminder 
/etc/init.d/mysql start
mysql -uroot --password=""< /usr/share/zoneminder/db/zm_create.sql 2>/dev/null
mysql -e "CREATE USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
mysqladmin -uroot --password="" reload 2>/dev/null


