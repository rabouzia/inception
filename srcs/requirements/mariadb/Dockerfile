FROM debian:bullseye

RUN apt-get update && apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY tools/mariadb.sh /

# RUN chmod +x tools/mariadb.sh

ENTRYPOINT [ "/mariadb.sh", "mysqld" ]
# ENTRYPOINT [ "/mariadb.sh", "tail", "-f" ]