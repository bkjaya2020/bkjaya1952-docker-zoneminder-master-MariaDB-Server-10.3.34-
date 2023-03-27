#!/bin/bash
/etc/init.d/mysql start
/etc/init.d/apache2 start
chmod 777 /var/run/zm
/usr/bin/zmpkg.pl start
