FROM debian:bookworm

RUN apt-get update
RUN apt install -y mariadb-server

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY tools/mariadb.sh /

# RUN chmod +x tools/mariadb.sh

ENTRYPOINT [ "/mariadb.sh" ]
