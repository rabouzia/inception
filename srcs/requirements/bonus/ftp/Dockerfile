FROM debian:bullseye

RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y vsftpd vim zsh

COPY conf/vfsdt.conf /etc/

COPY tools/ftp.sh /home/

RUN chmod +x /home/ftp.sh

ENTRYPOINT [ "/home/ftp.sh" ]