#!/bin/sh
cd /var/www/html

if [ -d "wordpress" ]; then
    echo "wordpress exists."
else
    echo "wordpress not exists." 
    mkdir -p wordpress
    cd wordpress
    
    curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
    php wp-cli.phar --info
    chmod +x wp-cli.phar
    mv wp-cli.phar /usr/local/bin/wp
    wp core download --allow-root 
    
    sleep 5
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --allow-root 
    sleep 5

    wp core install --url=ybelatar.42.fr --title=INCEPTION --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --allow-root  
    wp user create $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD --role=$WP_USER_ROLE --porcelain --allow-root 
    
    wp config set WP_REDIS_HOST redis --add --allow-root
    wp config set WP_REDIS_PORT 6379 --add --allow-root
    wp config set WP_CACHE true --add --allow-root
    wp plugin install contact-form-7 --activate --allow-root
    wp plugin install redis-cache --activate --allow-root
    wp theme delete twentynineteen twentytwenty --allow-root
    wp plugin delete hello --allow-root
    wp plugin update --all --allow-root  
    wp redis enable --allow-root  
    echo "END" 
fi

chown -R www-data:www-data /var/www/html/wordpress/wp-content/uploads

/usr/sbin/php-fpm7.4 -F