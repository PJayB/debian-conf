#!/bin/sh
if [ ! -f /usr/bin/curl ]; then
	echo Please install curl
	exit 1
fi

curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt-get update
sudo apt-get install -y code

if [ ! -d ~/.config/Code/User ]; then
    mkdir -vp ~/.config/Code/User
fi
cp -vnr ../config-templates/vscode/* ~/.config/Code/User/

