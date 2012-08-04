#!/bin/bash

#Проверяем на существование
if [ -d "/var/www/$1" ]; then
 echo "Domain name already exists!"
else
 mkdir -p /var/www/$1/public_html;
 mkdir -p /var/www/$1/logs;
 cat > /etc/apache2/sites-available/"$1" << EOF
<VirtualHost *:80>
ServerAdmin support@$1
ServerName $1
ServerAlias www.$1
DocumentRoot /var/www/$1/public_html
ErrorLog /var/www/$1/logs/error.log
CustomLog /var/www/$1/logs/access.log combined
</VirtualHost>
EOF
 #выставляем права на папки
 chown -R www-data:www-data /var/www/$1
 chmod 2775 /var/www/$1
 chmod 2775 /var/www/$1/public_html

 #создаем базу данных и пользователя
 #MyUSER="root"
 #MyPASS="Y73bdehd*j"
 #dbName = sed 's/\./_/' -e $1
 #dbPass="dbpass"

 #mysql -u $MyUSER -p$MyPASS -Bse "CREATE DATABASE $dbName;"
 #mysql -u $MyUSER -h localhost -p$MyPASS -Bse "CREATE USER '$1'@'localhost' IDENTIFIED BY '$dbPass';"
 #mysql -u $MyUSER -h localhost -p$MyPASS -Bse "GRANT ALL ON $1.* to $1 identified by $dbPass;"

 #включаем сайт
 sudo a2ensite $1
 sudo service apache2 reload
fi
