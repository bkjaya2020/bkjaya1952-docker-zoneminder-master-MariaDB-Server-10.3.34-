# bkjaya1952-docker-zoneminder-master-mysq:l81.33.16
Zoneminder-master , v1.33.16. docker image with Mysql 8 &amp; MSMTP


This image has been created on ubuntu:eoan with zoneminder-master/ubuntu disco main
To pull the Repository from the dockerhub
please refer the following link

https://hub.docker.com/r/bkjaya1952/docker-zoneminder-master-mysql8


Usage :

To create a Zonminder-master docker container (name zm)with mysql 8 & msmtp

On the Ubuntu terminal enter the following commands

sudo docker create -t -p 8080:80 --shm-size=4096m --name zm --privileged=true bkjaya1952/docker-zoneminder-master-mysql8:1.33.16

sudo docker start zm

(You will have to configure the running zm container for mysql 8 ,zm data base and make some changes to start apache and zoneminder during the first run .)

sudo docker exec -t -i zm /bin/bash

(Now you will be with in the zm container.

Make changes as follows)

/etc/init.d/mysql start

chown -R www-data:www-data /var/run/zm

sed -i "228i ServerName localhost" /etc/apache2/apache2.conf

mysql

CREATE USER 'admin'@'localhost' IDENTIFIED WITH mysql_native_password BY '';

GRANT ALL PRIVILEGES ON . TO 'admin'@'localhost' WITH GRANT OPTION;

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

service apache2 reload

exit

(As the apache service and zoneminder do not in running condition , when the zm container is started , we will have to edit the file "/etc/bash.bashrc" . For editing bash.bashrc is copied to the host and copied back to the container "zm" after making changes as follows. You will have to make these changes at the first time running only. )

(Open the Ubuntu terminal at the host)

sudo docker cp zm:/etc/bash.bashrc ~/Downloads ( Here i have copied the file to the Downloads folder of the computer)

(If go the Downloads folder, you can see the copied "bash.bashrc" file)

(In order to make changes to "bash.bashrc")

sudo chmod -R 777 ~/Downloads/bash.bashrc

sudo gedit ~/Downloads/bash.bashrc

(Now enter the following two lines at the bottom of the opened "bash.bashrc" file and save.)

/etc/init.d/apache2 start

/usr/bin/zmpkg.pl start

(To copy back the edited "bash.bashrc" to /etc/ of the container "zm" , run the following command on the terminal)

sudo docker cp ~/Downloads/bash.bashrc zm:/etc/

(Now you can restart the container to see whether the zoneminder is active as follows)

sudo docker restart zm

sudo docker exec -t -i zm /bin/bash

http://localhost:8080/zm/

(Note:- Each time , you start the container ,you will have to run " sudo docker exec -t -i zm /bin/bash" after "sudo docker start zm" to get the ZM Console) (To use msmtp for emailing please refer https://hub.docker.com/repository/docker/bkjaya1952/docker-zoneminder-master)

For more details on installation please refer the following link

https://bkjaya.wordpress.com/2020/01/14/how-to-install-zoneminder-master-docker-v1-33-16-with-mysql-8-msmtp-on-ubuntu-19-10-eoan-ermine/


For more details on composing the image and pushing to the docker hub can be obtained from the following mya blog post

https://bkjaya.wordpress.com/2020/01/15/how-to-build-a-zoneminder-master-docker-image-with-mysql-8-msmtp/


Any suggstions on improving the Dockerfile and entrypoint.sh are welcome.
