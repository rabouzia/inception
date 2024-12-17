FROM debian:bullseye

RUN apt-get update 
RUN apt install -y adminer 

COPY conf/000-default.conf /etc/apache2/sites-available/
RUN echo 'ServerName adminer' >> /etc/apache2/apache2.conf

RUN service apache2 start && a2enconf adminer.conf 

ENTRYPOINT ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]