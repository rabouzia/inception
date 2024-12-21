FROM debian:bullseye

RUN apt-get update && apt install php \ 
	wget redis php-redis php-mysqli \
	php-fpm php-cgi php-curl curl php-gd \
	php-mbstring php-xml php-xmlrpc php-soap \
	php-intl php-zip -y 

RUN apt-get update && \
    apt install default-mysql-client -y

RUN mkdir /run/php


COPY page/www.conf /etc/php/7.4/fpm/pool.d/

COPY conf/wordpress.sh /

RUN chmod +x /wordpress.sh

ENTRYPOINT [ "/wordpress.sh", "php-fpm7.4", "-F" ]