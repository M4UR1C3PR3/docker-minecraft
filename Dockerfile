FROM java:8
MAINTAINER maurice@preuss.io

ENV APT_GET_UPDATE 2016-12-13
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
  && mkdir /config \
  && mkdir /mods \
  && mkdir /plugins \
  && mkdir /home/minecraft \
  && chown minecraft:minecraft /data /config /mods /plugins /home/minecraft

RUN chmod +x /usr/local/bin/*

EXPOSE 25565

VOLUME ["/data","/mods","/config","/plugins","/home/minecraft"]

RUN curl -o /data/minecraft_server.jar https://launcher.mojang.com/mc/game/1.11/server/48820c84cb1ed502cb5b2fe23b8153d5e4fa61c0/server.jar

WORKDIR /data

CMD ["screen", "-S", "minecraft", "java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft_server.jar", "nogui"]
