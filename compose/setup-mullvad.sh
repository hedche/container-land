#!/bin/bash

# This script will take user input ot configure the mullvad vpn docker container

# This needs to be converted to an ansible

echo "Enter the Wireguard key: "
read -s wireguardKey

echo "Enter the Wireguard address in CIDR notation (i.e. 10.50.2.4/24): "
read address

echo "Enter city: "
read city

# Now we create the docker compose YAML

cat <<EOF > mullvad.yml
---
version: "3"
services:
  gluetun:
    image: qmcgaw/gluetun
    container_name: vpn
    cap_add:
      - NET_ADMIN
    environment:
      - VPN_SERVICE_PROVIDER=mullvad
      - VPN_TYPE=wireguard
      - WIREGUARD_PRIVATE_KEY=${wireguardKey}
      - WIREGUARD_ADDRESSES=${address}
      - SERVER_CITIES=${city}
EOF
