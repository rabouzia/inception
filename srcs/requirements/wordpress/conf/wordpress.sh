#!/bin/bash


sleep 5

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

cd /var/www/html/wordpress
chmod -R 755 /var/www/html/wordpress/
chown -R www-data:www-data /var/www/html/wordpress

check_core_files() {
    wp core is-installed --allow-root > /dev/null
    return $?
}
if ! check_core_files; then
    echo "[========WP INSTALLATION STARTED========]"
    find /var/www/html/wordpress/ -mindepth 1 -delete
    wp core download --allow-root
    wp core config --dbhost=mariadb:3306 --dbname="$MYSQL_DB" --dbuser="$MYSQL_USER" --dbpass="$MYSQL_PASSWORD" --allow-root
    wp core install --url="$DOMAIN_NAME" --title="$WP_TITLE" --admin_user="$WP_ADMIN_N" --admin_password="$WP_ADMIN_P" --admin_email="$WP_ADMIN_E" --allow-root
    wp user create "$WP_U_NAME" "$WP_U_EMAIL" --user_pass="$WP_U_PASS" --role="$WP_U_ROLE" --allow-root
else
    echo "[========WordPress files already exist. Skipping installation========]"
fi

#---------------------------------------------------php config---------------------------------------------------#

sed -i '36 s@/run/php/php7.4-fpm.sock@9000@' /etc/php/7.4/fpm/pool.d/www.conf
mkdir -p /run/php
/usr/sbin/php-fpm7.4 -F