# bkjaya1952/zoneminder-master-docker-latest
Zoneminder-master , latest. docker image with Mysql 8 &amp; MSMTP

Based on Isaac Connor's ZoneMinder Master Snapshots at https://launchpad.net/~iconnor/+archive/ubuntu/zoneminder-master


This image has been created on ubuntu:focal with zoneminder-master/ubuntu focal main
To pull the Repository from the dockerhub
please refer the following link

https://hub.docker.com/r/bkjaya1952/zoneminder-master-docker-latest


Usage :

To create a Zonminder-master docker container (name zm)with mysql 8 & msmtp

On the Ubuntu terminal enter the following commands

<code>sudo docker create -t -p 8080:80 --shm-size=4096m --name zm --privileged=true bkjaya1952/zoneminder-master-docker-latest</code>

<code>sudo docker start zm</code>

(You will have to configure the running zm container for mysql 8 ,zm data base and edit the timezone  during the first run .)

<code>sudo docker exec -t -i zm /bin/bash</code>

(Now  you will be with in the zm container.

Make changes as follows)

(Configuring Mysql and Changing  root password)

<code>mysql</code>

<code>ALTER USER 'root'@'localhost' IDENTIFIED BY 'yourpassword';</code>


<code>FLUSH PRIVILEGES ;</code>

<code>quit</code>

(Creating zm sql data base)

<code>mysql -uroot -p < /usr/share/zoneminder/db/zm_create.sql</code>

<code>mysql</code>

<code>CREATE USER 'zmuser'@localhost IDENTIFIED BY 'zmpass';</code>

(If CREATE does not work try with ALTER )

<code>GRANT ALL PRIVILEGES ON zm.* TO 'zmuser'@'localhost' WITH GRANT OPTION;</code>

<code>FLUSH PRIVILEGES ;</code>

<code>quit</code>

<code>mysqladmin -uroot -p reload</code>

(Note:- Here use the 'yourpassword' created for 'root'@'localhost' earlier )

<code>dpkg-reconfigure tzdata</code>

Then edit your timezone

<code>exit</code>

<code>sudo docker restart zm</code>

<code>http://localhost:8080/zm/</code>

(To use msmtp for emailing please refer https://hub.docker.com/repository/docker/bkjaya1952/docker-zoneminder-master)

( The procedure of  composing an image can be obtained from the following links

https://bkjaya.wordpress.com/2020/01/15/how-to-build-a-zoneminder-master-docker-image-with-mysql-8-msmtp/  )

# Note:- If you want your docker container zm to detect ip camera automatically, you will have to use following command when creating the container .

<code>sudo docker create -t -p 80:80 --shm-size=4096m --name zm --network=host --privileged=true bkjaya1952/zoneminder-master-docker-latest</code>

In this case you will have to restrain in using the port 80 in your host for any other purpose when running the zm container.

Then the zoneminder web panel will be at <code>http://localhost/zm/</code>


