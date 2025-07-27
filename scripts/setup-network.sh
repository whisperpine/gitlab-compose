#!/bin/sh

# Purpose: create a docker macvlan network
# Usage: sh ./scripts/setup-network.sh
# Dependencies: docker
# Date: 2024-04-07
# Author: Yusong

# Make sure you're using the correct value in each line:
# --subnet are normally in the form of "196.168.x.x/x" or "10.x.x.x/x".
# --gateway typically should be the ip address of your router.
# "eth0" should be replaced by the authentic NIC (network interface).
# Find out the NIC name with command `ip address show`.

docker network create -d macvlan \
    --subnet 192.168.3.0/24 \
    --gateway 192.168.3.1 \
    -o parent=eth0 \
    macvlan
