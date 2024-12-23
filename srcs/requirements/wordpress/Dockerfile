FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y curl php php7.4-fpm php-mysql mariadb-client wget vim zsh git netcat mycli

COPY /conf/wordpress.sh /

RUN  chmod +x wordpress.sh

ENTRYPOINT ["./wordpress.sh", "php-fpm7.4", "-F"]