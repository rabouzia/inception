FROM debian:bullseye

RUN apt-get update -y && \
    apt-get upgrade -y  && \
    apt-get install -y iproute2 vim curl jq ca-certificates apt-transport-https gnupg wget vim zsh && \
    rm -rf /var/lib/apt/lists/*


RUN wget -O - https://apt.corretto.aws/corretto.key | gpg --dearmor -o /usr/share/keyrings/corretto-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list

RUN apt-get update && \
    apt-get install -y java-21-amazon-corretto-jdk


RUN mkdir -p /minecraft

WORKDIR /minecraft

COPY conf/eula.txt /minecraft/
COPY conf/server.properties /minecraft/
COPY tools/minecraft.sh /minecraft/

RUN wget https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar -O /minecraft/server.jar 

RUN chmod +x /minecraft/minecraft.sh

ENTRYPOINT [ "/minecraft/minecraft.sh" ]