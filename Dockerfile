FROM ubuntu:22.10
MAINTAINER B.K.Jayasundera

# Update base packages
RUN apt update 
    

ARG DEBIAN_FRONTEND=noninteractive


COPY zm.sh /usr/bin/zm.sh
RUN apt install -y software-properties-common  
RUN chmod 777 /usr/bin/zm.sh && \
    zm.sh 
    
    
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
 

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
    
    
# Expose http port
EXPOSE 80
COPY startzm.sh /usr/bin/startzm.sh
COPY firstrun.sh /usr/bin/firstrun.sh
COPY updatemysql.sh /usr/bin/updatemysql.sh
RUN chmod 777 /usr/bin/startzm.sh
RUN chmod 777 /usr/bin/firstrun.sh
RUN chmod 777 /usr/bin/updatemysql.sh
CMD ["/usr/bin/supervisord"]
