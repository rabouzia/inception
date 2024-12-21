FROM debian:bullseye

RUN apt-get update && apt install -y adminer php-fpm

# COPY conf/000-default.conf /etc/apache2/sites-available/
# RUN echo 'ServerName adminer' >> /etc/apache2/apache2.conf

# RUN service apache2 start && a2enconf adminer.conf 

RUN mkdir /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/

ENTRYPOINT ["php-fpm7.4", "-F" ]