#!/bin/bash

#umask 002
export HOME=/data

if [ ! -e /data/eula.txt ]; then
  echo "# Generated via Docker on $(date)" > eula.txt
  echo "eula=true" >> eula.txt
fi

if [ ! -e /data/minecraft.jar ]; then
  echo "# Downloading Minecraft..."
  curl -o /data/minecraft_server.jar https://launcher.mojang.com/mc/game/1.11/server/48820c84cb1ed502cb5b2fe23b8153d5e4fa61c0/server.jar
fi

echo "# Starting screen..."
screen -Smd docker -m java $JVM_OPTS -jar minecraft_server.jar

# keep in foreground.
echo "Done!"
exec tail -f /dev/null
