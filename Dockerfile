FROM java:8

MAINTAINER maurice@preuss.io

ENV APT_GET_UPDATE 2016-12-15
RUN apt-get update

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
  imagemagick \
  lsof \
  nano \
  sudo \
  vim \
  jq \
  screen \
  && apt-get clean

RUN useradd -s /bin/false --uid 1000 minecraft \
  && mkdir /data \
  && mkdir /home/minecraft \
  && chown minecraft:minecraft /data /home/minecraft

EXPOSE 25565

COPY start.sh /start
COPY start-minecraft.sh /start-minecraft
RUN chmod +x /start
RUN chmod +x /start-minecraft
RUN chmod +x /usr/local/bin/*

VOLUME ["/data","/home/minecraft"]
WORKDIR /data

ENTRYPOINT [ "/start" ]

ENV UID=1000 GID=1000 \
    MOTD="A Minecraft Server Powered by Preuss.IO" \
    JVM_OPTS="-Xmx1024M -Xms1024M"
