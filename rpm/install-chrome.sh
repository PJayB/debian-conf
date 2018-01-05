#!/bin/sh

echo Installing Google Chrome...
sudo sh -c 'cat > /etc/yum.repos.d/google-chrome.repo' <<- EOM
[google-chrome]
name=Google Chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://dl-ssl.google.com/linux/linux_signing_key.pub
EOM

sudo yum install -y google-chrome-stable


