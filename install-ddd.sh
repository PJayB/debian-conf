#!/bin/bash
set -e
sudo apt install -y ddd
mkdir -p ~/.ddd
cp -nv config-templates/ddd-init ~/.ddd/init
