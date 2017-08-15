#!/bin/bash

if [ ! -f /usr/bin/curl ]; then
	echo "Please install curl."
	exit 1
fi
if [ ! -f /usr/bin/wget ]; then
	echo "Please install wget."
	exit 1
fi

echo Fetching Unity download page...
if [ -f public_download.html ]; then
	rm public_download.html
fi

if [ "$1" == "" ]; then
	echo "Please get latest URL of public_download.html from the Forums!"
	echo "https://forum.unity3d.com/threads/unity-on-linux-release-notes-and-known-issues.350256/"
	exit 1
fi

UNITYURL=$1
INSTALLER=$(curl $UNITYURL | grep -i -o -E "(http[^'>]*\.deb)")
if [ $? -ne 0 ]; then
	echo "Failed to acquire download URL from $UNITYURL"
	exit 1
fi
if [ "$INSTALLER" == "" ]; then
	echo "Acquired download page, but couldn't find the URL. Please check $UNITYURL."
	exit 1
fi

INSTALLER_FILE=$(echo ${INSTALLER} | grep -i -o -E "[^/]+$")

echo Installing from $INSTALLER_FILE...

if [ ! -f $INSTALLER_FILE ]; then
	wget $INSTALLER
fi

sudo dpkg -i $INSTALLER_FILE
if [ $? -eq 0 ]; then
	sudo apt-get --fix-broken install
	rm $INSTALLER_FILE
fi



