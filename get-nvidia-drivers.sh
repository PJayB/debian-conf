#!/bin/bash
sudo apt install software-properties-common linux-headers-lowlatency
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt-get update
sudo apt-get upgrade
apt-cache search nvidia

