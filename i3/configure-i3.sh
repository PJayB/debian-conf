#!/bin/bash
set -e

I3=~/.config/i3

mkdir -p $I3
mkdir -p ~/.config/i3status
mkdir -p ~/.config/dunst

cd $(dirname $0)
cp -v ./i3-config $I3/config
cp -nv ./i3status-config ~/.config/i3status/config || echo "NOTE: i3status not overwritten" >&2
cp -v ./volume-adjust.sh $I3/
cp -v ./i3-startup.sh $I3/
cp -v ./lock.sh $I3/
cp -v ./dunstrc ~/.config/dunst/dunstrc

echo "NOTE: If you want DPI scaling, output your DPI to $I3/custom-dpi"

# Restart dunst to pick up the dunstrc
killall dunst; notify-send "i3 Configured!"

# Try to setup pulse audio (may fail to select one on desktops with lots of audio sinks)
source pulse-setup.sh || :

# Warn if arandr is not installed
[ -e /usr/bin/arandr ] || echo "NOTE: Don't forget to install arandr if you want better multimonitor config"

# Set up pulse (or try, anyway)
./pulse-setup.sh || echo "Please run pulse-setup.sh again to fix volume control"


