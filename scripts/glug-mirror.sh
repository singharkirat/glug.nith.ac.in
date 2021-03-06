#!/bin/bash

DOMAIN='172.16.30.30'
# Set this DOMAIN variable to either
# `glug.nith.ac.in` if you cannot directly ping 172.16.30.30
# or `172.16.30.30` if you can ping 172.16.30.30 directly.
# Later option have generally more advantage of speed.

# Following finds the codename of the distribution.
CODENAME=`lsb_release -c | awk '{print $2}'`

# Following condition checks for the sudo access.
if [[ $EUID -ne 0 ]]; then
    echo "You must be root to do this. Run as "
    echo "sudo ./glug-mirror.sh"
    exit 100
fi

if ! [ -f /etc/apt/sources.list ]; then
    touch /etc/apt/sources.list
fi

sed 's/^/#/' /etc/apt/sources.list > /etc/apt/sources.list.new
mv /etc/apt/sources.list /etc/apt/sources.list.old
mv /etc/apt/sources.list.new /etc/apt/sources.list

echo "deb http://$DOMAIN/ubuntu/archives/ $CODENAME main restricted universe multiverse
deb-src http://$DOMAIN/ubuntu/archives/ $CODENAME main restricted universe multiverse

deb http://$DOMAIN/ubuntu/archives/ $CODENAME-updates main restricted universe multiverse
deb-src http://$DOMAIN/ubuntu/archives/ $CODENAME-updates main restricted universe multiverse

deb http://$DOMAIN/ubuntu/archives/ $CODENAME-security main restricted universe multiverse
deb-src http://$DOMAIN/ubuntu/archives/ $CODENAME-security main restricted universe multiverse

deb http://$DOMAIN/ubuntu/archives/ $CODENAME-backports main restricted universe multiverse
deb-src http://$DOMAIN/ubuntu/archives/ $CODENAME-backports main restricted universe multiverse
" >> /etc/apt/sources.list
