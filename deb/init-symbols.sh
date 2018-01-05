#!/bin/bash
#DISTROS="precise quantal raring saucy trusty utopic vivid wily xenial yakkety zesty artful $(lsb_release -cs)"
DISTROS="$(lsb_release -cs) trusty vivid xenial yakkety zesty artful"
for distro in $DISTROS; do
	echo "# Symbols
deb http://ddebs.ubuntu.com $distro main restricted universe multiverse
deb http://ddebs.ubuntu.com $distro-updates main restricted universe multiverse
#deb http://ddebs.ubuntu.com $distro-security main restricted universe multiverse
deb http://ddebs.ubuntu.com $distro-proposed main restricted universe multiverse
# Sources
deb-src http://us.archive.ubuntu.com/ubuntu $distro main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu $distro-updates main restricted universe multiverse
#deb-src http://us.archive.ubuntu.com/ubuntu $distro-security main restricted universe multiverse
deb-src http://us.archive.ubuntu.com/ubuntu $distro-proposed main restricted universe multiverse" | \
	sudo tee /etc/apt/sources.list.d/ubuntu-$distro-sources.list
done

sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5FDFF622
sudo apt-key update
sudo apt update

