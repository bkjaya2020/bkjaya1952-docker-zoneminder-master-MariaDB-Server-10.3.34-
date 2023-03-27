add-apt-repository ppa:iconnor/zoneminder-master
apt -y install msmtp tzdata gnupg supervisor
apt -y install mysql-server
apt -y install zoneminder
/etc/init.d/mysql start
mysql -e "ALTER USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';"
mysql -e "GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;"
mysql -e "FLUSH PRIVILEGES ;"
mysqladmin -uroot --password="" reload 2>/dev/null
zmupdate.pl
