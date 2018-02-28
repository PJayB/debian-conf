#!/bin/bash
set -e

I3=~/.config/i3

if [ ! -d $I3 ]; then
    mkdir -p $I3
fi
if [ ! -d ~/.config/i3status ]; then
    mkdir -p ~/.config/i3status
fi

cd $(dirname $0)
cp -v ./i3-config $I3/config
cp -v ./i3status-config ~/.config/i3status/config
cp -v ./volume-adjust.sh $I3/

echo "TODO: If you want DPI scaling, output your DPI to $I3/custom-dpi"

source pulse-setup.sh
