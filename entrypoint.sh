#!/bin/bash
chown -R www-data:www-data /var/run/zm
service mysql start
systemctl enable zoneminder
/usr/bin/zmpkg.pl start
/etc/init.d/apache2 start
tail -F n0 /dev/null
