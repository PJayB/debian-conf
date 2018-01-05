#!/bin/bash
set -e
#echo "deb https://packagecloud.io/grafana/stable/debian/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/grafana.list
echo "deb https://packagecloud.io/grafana/stable/debian/ jessie main" > /etc/apt/sources.list.d/grafana.list
curl https://packagecloud.io/gpg.key | sudo apt-key add -
apt-get update
apt-get install -y grafana

