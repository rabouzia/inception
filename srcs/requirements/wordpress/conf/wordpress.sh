#!/bin/bash

sleep 5

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

mkdir /var/www/html/wordpress/

cd /var/www/html/wordpress/
chmod -R 755 /var/www/html/wordpress/
chown -R www-data:www-data /var/www/html/wordpress


echo "[========WP INSTALLATION STARTED========]"
find /var/www/html/wordpress/ -mindepth 1 -delete
wp core download --allow-root
wp core config --dbhost=mariadb:3306 --dbname="$BDD_NAME" --dbuser="$BDD_USER" --dbpass="$BDD_USER_PASSWORD" --allow-root
wp core install --url="$DOMAIN_NAME" --title="$TITLE" --admin_user="$WP_ADMIN_USER" --admin_password="$WP_ADMIN_PASSWORD" --admin_email="$WP_ADMIN_EMAIL" --allow-root
wp user create "$WP_USER" "$WP_USER_EMAIL" --user_pass="$WP_USER_PASSWORD"--allow-root
sleep 5 

wp config set WP_REDIS_HOST redis --add --allow-root
wp config set WP_REDIS_PORT 6379 --add --allow-root
wp config set WP_CACHE true --add --allow-root
wp plugin install contact-form-7 --activate --allow-root
wp plugin install redis-cache --activate --allow-root
wp theme delete twentynineteen twentytwenty --allow-root
wp plugin delete hello --allow-root
wp plugin update --all --allow-root  
wp redis enable --allow-root  

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php
# chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads

# /usr/sbin/php-fpm7.4 -F
exec $@

