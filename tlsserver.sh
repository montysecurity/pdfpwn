#!/bin/bash

if [ "$EUID" -ne 0 ]
then
	echo -e "\e[91m[-]\e[0m Error: Permission Denied"
	exit
fi

apt update && apt install apache2 -y
a2enmod ssl
a2ensite default-ssl.conf
service apache2 restart && echo -e "\e[92m[+]\e[0m TLS Server Properly Installed: /var/www/html"
