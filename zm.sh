add-apt-repository ppa:iconnor/zoneminder-master 
apt -y install mariadb-server
apt -y install zoneminder 
/etc/init.d/mysql start
