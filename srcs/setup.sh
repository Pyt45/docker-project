apt update
apt upgrade
apt install -y nginx wget gnupg lsb-release
wget https://repo.mysql.com//mysql-apt-config_0.8.13-1_all.deb
printf "1\n1\n4\n" | dpkg -i mysql-apt-config_0.8.13-1_all.deb
apt -y update
apt install -y mysql-server
apt install -y php-mbstring php-zip php-gd php-xml php-pear php-gettext php-cli php-cgi
apt install -y php-fpm php-mysql

#NGINX CONFUGIRATION
service nginx start
cp /usr/bin/default /etc/nginx/sites-available/default
service nginx restart
service php7.3-fpm start

#PHPMYADMIN
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz
wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-english.tar.gz.asc
mkdir /var/www/html/phpmyadmin
tar xzf phpMyAdmin-4.9.0.1-english.tar.gz --strip-components=1 -C /var/www/html/phpmyadmin
cp /usr/bin/config.inc.php /var/www/html/phpmyadmin/config.inc.php
chmod 660 /var/www/html/phpmyadmin/config.inc.php
chown -R www-data:www-data /var/www/html/phpmyadmin

#MYSQL
service mysql start
echo "create database wordpress;" | mysql -u root -p
echo "create user ayoub@localhost identified by 'ayoub1234';" | mysql -u root -p
echo "grant all privileges on wordpress.* to ayoub@localhost;" | mysql -u root -p
echo "flush privileges;" | mysql -u root -p
echo "quit" | mysql -u root -p

#WORDPRESS
apt install -y php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip
service nginx reload
mkdir /var/www/html/wordpress
wget https://wordpress.org/latest.tar.gz -P /tmp
tar xzf /tmp/latest.tar.gz --strip-components=1 -C /var/www/html/wordpress
rm latest.tar.gz
cp /usr/bin/wp-config.php /var/www/html/wordpress/wp-config.php
chown -R www-data:www-data /var/www/html/wordpress

#SSL
printf "US\ntest\ntest\ntest\ntest\ntest\ntest\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
cp /usr/bin/default1 /etc/nginx/sites-available/default

#restart every thing
nginx -t
service nginx restart
bash
