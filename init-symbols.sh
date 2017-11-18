#!/bin/sh
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-security main restricted universe multiverse
deb http://ddebs.ubuntu.com $(lsb_release -cs)-proposed main restricted universe multiverse" | \
sudo tee /etc/apt/sources.list.d/ddebs.list

echo "deb-src http://us.archive.ubuntu.com/ubuntu $(lsb_release -cs) main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu $(lsb_release -cs)-updates main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu $(lsb_release -cs)-security main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu $(lsb_release -cs)-proposed main restricted universe multiverse" | \
sudo tee /etc/apt/sources.list.d/ubuntu-src.list

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5FDFF622
sudo apt-key update
sudo apt update

