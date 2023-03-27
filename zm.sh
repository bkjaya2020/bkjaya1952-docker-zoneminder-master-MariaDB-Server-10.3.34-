apt-key adv --fetch-keys 'https://mariadb.org/mariadb_release_signing_key.asc'
add-apt-repository 'deb [arch=amd64,arm64,ppc64el] http://mirror.biznetgio.com/mariadb/repo/10.5/ubuntu focal main'
apt update
apt -y install mariadb-server
add-apt-repository ppa:iconnor/zoneminder-master 
apt -y install zoneminder 
/etc/init.d/mysql start
mysql -uroot --password=""< /usr/share/zoneminder/db/zm_create.sql 2>/dev/null
mysql -e "ALTER USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
mysqladmin -uroot --password="" reload 2>/dev/null
