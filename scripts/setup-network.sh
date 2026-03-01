#!/bin/sh

# Purpose: create a docker network with the ipvlan driver
# Usage: sh ./scripts/setup-network.sh
# Dependencies: docker
# Date: 2024-04-07
# Author: Yusong

set -e

if ! lsmod | grep -q ipvlan; then
  echo "Error: Cannot find the 'ipvlan' kernel module."
  exit 1
fi

# Make sure you're using the correct value in each line:
# --subnet are normally in the form of "196.168.x.x/x" or "10.x.x.x/x".
# --gateway typically should be the ip address of your router.
# "wlo1" should be replaced by the authentic network interface (NIC).
# List all available the NIC names with command `ip -br addr`.

docker network create -d ipvlan \
  --subnet 192.168.3.0/24 \
  --gateway 192.168.3.1 \
  -o parent=wlo1 \
  ipvlan
