#!/bin/sh

docker network create -d macvlan \
    --subnet 192.168.3.0/24 \
    --gateway 192.168.3.1 \
    -o parent=eth0 \
    macvlan
