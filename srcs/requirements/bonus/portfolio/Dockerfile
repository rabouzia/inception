FROM debian:bullseye

RUN apt update && \
    apt upgrade -y && \
    apt-get install -y python3

RUN mkdir website

COPY conf/* /

CMD [ "python3", "-m", "http.server", "3000" ]