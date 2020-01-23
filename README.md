# bkjaya1952-docker-zoneminder-master-mysql8:latest
Zoneminder-master , latest. docker image with Mysql 8 &amp; MSMTP


This image has been created on ubuntu:eoan with zoneminder-master/ubuntu eoan main
To pull the Repository from the dockerhub
please refer the following link

https://hub.docker.com/r/bkjaya1952/docker-zoneminder-master-mysql8


Usage :

To create a Zonminder-master docker container (name zm)with mysql 8 & msmtp

On the Ubuntu terminal enter the following commands

<code>sudo docker create -t -p 8080:80 --shm-size=4096m --name zm --privileged=true bkjaya1952/docker-zoneminder-master-mysql8:tag

sudo docker start zm</code>

(You will have to configure the running zm container for mysql 8 ,zm data base and make some changes to start apache and zoneminder during the first run .)

<code>sudo docker exec -t -i zm /bin/bash</code>

(Now  you will be with in the zm container.

Make changes as follows)

<code>/etc/init.d/mysql start

chown -R www-data:www-data /var/run/zm

mysql

CREATE USER 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY '';

GRANT ALL PRIVILEGES ON zm.* TO 'admin'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES ;

quit

mysqladmin -uroot -p reload

mysql -uroot -p < /usr/share/zoneminder/db/zm_create.sql

mysql

CREATE USER 'zmuser'@localhost IDENTIFIED WITH mysql_native_password BY 'zmpass';

GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES ;

quit

mysqladmin -uroot -p reload

service apache2 start

service apache2 reload

exit</code>


sudo docker cp zm:/etc/apache2/apache2.conf ~/Downloads

sudo chmod -R 777 ~/Downloads/apache2.conf

sudo gedit ~/Downloads/apache2.conf

Enter the following line at the bottom of the opened file and save the file 

ServerName localhost

sudo docker cp ~/Downloads/apache2.conf zm:/etc/apache2/apache2.conf



(As the apache service and zoneminder do not in running condition , when the zm container is started , we will have to edit the file "/etc/bash.bashrc" . For editing bash.bashrc is copied to the host and copied back to the container "zm" after making changes as follows. You will have to make these changes at the first time running only.  )

Note:- bash.bashrc file editing is not necessary for the   bkjaya1952/docker-zoneminder-master-mysql8:1.33.16e 

(Open the Ubuntu terminal at the host)

<code>sudo docker cp zm:/etc/bash.bashrc ~/Downloads </code> 
( Here i have copied the file to the Downloads folder of the computer)

(If go the Downloads folder, you can  see the copied "bash.bashrc" file)

(In order to make changes to "bash.bashrc")

<code>sudo chmod -R 777 ~/Downloads/bash.bashrc

sudo gedit ~/Downloads/bash.bashrc</code>

(Now enter the following three lines at the bottom of the opened "bash.bashrc" file and save.)

<code>/etc/init.d/mysql start
 
 /etc/init.d/apache2 start

/usr/bin/zmpkg.pl start</code>

(To copy back the edited "bash.bashrc" to /etc/  of the container "zm" , run the following command on the terminal)

<code>sudo docker cp ~/Downloads/bash.bashrc zm:/etc/</code>

(Now you can restart the container to see whether the zoneminder is active as follows)

<code>sudo docker restart zm
 
 sudo docker exec -t -i zm /bin/bash</code>

<code>http://localhost:8080/zm/</code>

Note:- If you find any timezone mismatch in zoneminder logs , correct it as follows.( ie for America/New_York )

On the ubuntu terminal

<code>sudo docker start zm

sudo docker exec -t -i zm /bin/bash

dpkg-reconfigure tzdata

Then edit your timezone

exit</code>


(Note:- Each time , you start the container ,you will have to run " sudo docker exec -t -i zm /bin/bash"  after "sudo docker start zm"  to get the ZM Console)

(To use msmtp for emailing please refer https://hub.docker.com/repository/docker/bkjaya1952/docker-zoneminder-master)

( The procedure of  composing an image can be obtained from the following links

https://bkjaya.wordpress.com/2020/01/15/how-to-build-a-zoneminder-master-docker-image-with-mysql-8-msmtp/  )

