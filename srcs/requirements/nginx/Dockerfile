FROM debian:bullseye

RUN apt-get update && \
    apt install -y nginx openssl && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/nginx/ssl

# SETUP TLS CERTIFICATE
RUN openssl req \
            -x509 \
            -nodes \
            -days 365 \
            -newkey rsa:2048 \
            -keyout /etc/ssl/private/nginx-selfsigned.key \
            -out /etc/ssl/certs/nginx-selfsigned.crt \
            -subj '/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=RABOUZIA/UID=RB'

RUN echo "ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;\nssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;" > /etc/nginx/snippets/self-signed.conf
RUN openssl dhparam -out /etc/nginx/dhparam.pem 2048
COPY conf/ssl_cert.conf /etc/nginx/snippets/

COPY conf/default    /etc/nginx/sites-available/default
COPY conf/index.html    /var/www/html/wordpress/index.html
# COPY conf/adminer.conf /etc/nginx/sites-available
# RUN  ln -s /etc/nginx/sites-available/adminer.conf /etc/nginx/sites-enabled/


ENTRYPOINT ["nginx", "-g", "daemon off;"]