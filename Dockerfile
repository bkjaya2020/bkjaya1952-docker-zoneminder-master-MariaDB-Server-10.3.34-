FROM ubuntu:focal
MAINTAINER B.K.Jayasundera

# Update base packages
RUN apt update && \
    apt upgrade --assume-yes

ARG DEBIAN_FRONTEND=noninteractive

RUN apt install -y software-properties-common  
RUN add-apt-repository ppa:iconnor/zoneminder-master && \
    apt update && \
    apt -y install gnupg msmtp tzdata supervisor zoneminder && \ 
    rm -rf /var/lib/apt/lists/* && \ 
    apt -y autoremove && \ 
    rm /etc/mysql/my.cnf && \
    cp /etc/mysql/mysql.conf.d/mysqld.cnf  /etc/mysql/my.cnf && \ 
    service mysql restart


ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
 
# Set our volumes before we attempt to configure apache
VOLUME /var/cache/zoneminder/events /var/lib/mysql /var/log/zm /var/run/zm


RUN chmod 740 /etc/zm/zm.conf && \
    chown root:www-data /etc/zm/zm.conf && \
    adduser www-data video && \
    a2enmod cgi && \
    a2enconf zoneminder && \
    a2enmod rewrite && \
    a2enmod headers && \
    a2enmod expires && \
    ln -s /usr/bin/msmtp /usr/sbin/sendmail && \
    sed -i "228i ServerName localhost" /etc/apache2/apache2.conf && \    
    /etc/init.d/apache2 start
RUN chmod 777 /var/run/zm
RUN /etc/init.d/apache2 restart

# Expose http port
EXPOSE 80
CMD ["/usr/bin/supervisord"]
