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

mysql -uroot -p < /usr/share/zoneminder/db/zm_create.sql

mysql

CREATE USER 'zmuser'@localhost IDENTIFIED WITH mysql_native_password BY 'zmpass';

GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES ;

quit

mysqladmin -uroot -p reload

exit</code>

<code>sudo docker restart zm
 
 sudo docker exec -t -i zm /bin/bash</code>

<code>http://localhost:8080/zm/</code>

Note:- If you find any timezone mismatch in zoneminder logs , correct it as follows.( ie for America/New_York )

On the ubuntu terminal

<code>sudo docker exec -t -i zm /bin/bash

dpkg-reconfigure tzdata

Then edit your timezone

exit</code>


(Note:- Each time , you start the container ,you will have to run " sudo docker exec -t -i zm /bin/bash"  after "sudo docker start zm"  to get the ZM Console)

(To use msmtp for emailing please refer https://hub.docker.com/repository/docker/bkjaya1952/docker-zoneminder-master)

( The procedure of  composing an image can be obtained from the following links

https://bkjaya.wordpress.com/2020/01/15/how-to-build-a-zoneminder-master-docker-image-with-mysql-8-msmtp/  )
