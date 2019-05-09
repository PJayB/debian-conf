#!/bin/bash
BCDEB=bcompare-4.2.9.23626_amd64.deb
wget https://www.scootersoftware.com/$BCDEB
sudo apt-get update
sudo apt-get install gdebi-core
sudo gdebi $BCDEB


