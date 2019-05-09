#!/bin/bash
wget https://www.scootersoftware.com/bcompare-4.2.9.23626_amd64.deb
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi bcompare-4.2.3.22587_amd64.deb

