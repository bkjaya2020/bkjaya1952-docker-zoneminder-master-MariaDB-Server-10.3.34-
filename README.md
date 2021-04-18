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

<code>sudo docker create -t -p 8080:80 --name zm --privileged=true -e TZ=Asia/Colombo bkjaya1952/zoneminder-master-docker-latest</code>

Note:- Replace Asia/Colombo  with your Time Zone 

<code>sudo docker start zm</code>

<code>sudo docker exec -t -i zm /bin/bash</code>

<code>updatemysql.sh </code>

<code>exit</code>

<code>sudo docker restart zm</code>

<code>http://localhost:8080/zm/</code>


(To use msmtp for emailing please refer https://bkjaya.wordpress.com/2020/12/24/how-to-install-the-latest-zoneminder-master-latest-on-ubuntu-20-04-using-a-docker-image/)



# Note:- If you want your docker container zm to detect ip camera automatically, you will have to use following command when creating the container .

<code>sudo docker create -t -p 80:80 --name zm --network=host --privileged=true -e TZ=Asia/Colombo bkjaya1952/zoneminder-master-docker-latest</code>

In this case you will have to restrain in using the port 80 in your host for any other purpose when running the zm container.

Then the zoneminder web panel will be at <code>http://localhost/zm/</code>


