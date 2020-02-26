FROM ubuntu:eoan
MAINTAINER B.K.Jayasundera

# Update base packages
RUN apt update && \
    apt upgrade --assume-yes

ARG DEBIAN_FRONTEND=noninteractive

    
RUN apt -y install gnupg mysql-server msmtp tzdata supervisor && \ 
    rm -rf /var/lib/apt/lists/* && \ 
    apt -y autoremove
RUN apt -y install zoneminder 1.34

RUN rm /etc/mysql/my.cnf && \
    cp /etc/mysql/mysql.conf.d/mysqld.cnf /etc/mysql/my.cnf && \
    sed -i "15i default_authentication_plugin= mysql_native_password" /etc/mysql/my.cnf && \
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
    chown -R www-data:www-data /usr/share/zoneminder/ && \
    ln -s /usr/bin/msmtp /usr/sbin/sendmail && \
    sed -i "228i ServerName localhost" /etc/apache2/apache2.conf && \
    chown -R www-data:www-data /var/run/zm && \
    chmod 777 /var/run/zm && \
    /etc/init.d/apache2 start


# Expose http port
EXPOSE 80
COPY startzm.sh /usr/bin/startzm.sh
RUN chmod 777 /usr/bin/startzm.sh
