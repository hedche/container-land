#!/bin/bash

# This script will take user input ot configure the mullvad vpn docker container

# This needs to be converted to an ansible

echo "Enter transmission username: "
read user

echo "Enter transmission password: "
read -s password

echo "Enter whitelist IP range (i.e. 10.0.0.0/16): "
read whitelist

echo "Enter desired download directory (i.e. /mnt/HDD/downloads):  "
read downloadDir

# Now we create the docker compose YAML

cat <<EOF > transmission.yml
---
version: "2.1"
services:
  transmission:
    image: lscr.io/linuxserver/transmission:latest
    container_name: transmission
    environment:
      - PUID=1000
      - PGID=1000
      - TZ=Europe/London
      - TRANSMISSION_WEB_HOME=/combustion-release/
      - USER=${user}
      - PASS=${password}
      - WHITELIST=${whitelist}
    volumes:
      - ${downloadDir}:/downloads
    ports:
      - 9091:9091
      - 51413:51413
      - 51413:51413/udp
    restart: unless-stopped


EOF
