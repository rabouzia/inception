FROM debian:bullseye


RUN apt -y update 

COPY ./conf/adminer.sh /

RUN chmod +x /adminer.sh && \
	apt install wget -y && apt install php php-mysql  -y


CMD ["./adminer.sh"]