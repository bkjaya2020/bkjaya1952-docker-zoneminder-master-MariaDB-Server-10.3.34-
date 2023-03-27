apt-get install mariadb-server=10.3.14-1 mariadb-client=10.3.14-1 libmariadb3=10.3.14-1 mariadb-backup=10.3.14-1 mariadb-common=10.3.14-1

add-apt-repository ppa:iconnor/zoneminder-master 
apt -y install zoneminder 
/etc/init.d/mysql start
mysql -uroot --password=""< /usr/share/zoneminder/db/zm_create.sql 2>/dev/null
mysql -e "ALTER USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
mysqladmin -uroot --password="" reload 2>/dev/null
