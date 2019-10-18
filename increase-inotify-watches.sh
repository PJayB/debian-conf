#!/bin/sh
echo "fs.inotify.max_user_watches=1524288" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

