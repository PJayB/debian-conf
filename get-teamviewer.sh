#!/bin/bash
if [ ! -f teamviewer_i386.deb ]; then
	wget https://download.teamviewer.com/download/teamviewer_i386.deb
fi

sudo dpkg -i teamviewer_i386.deb

if [ $? -ne 0 ]; then
	echo "Errors occurred during installation. Maybe run apt-get --fix-broken install, then re-run this."
else
	rm teamviewer_i386.deb
fi

