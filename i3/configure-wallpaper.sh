#!/bin/bash
sudo apt install nitrogen
nitrogen /usr/share/backgrounds

SUSCRIPT=~/.config/i3/custom-startup.sh

if cat $SUSCRIPT | grep "nitrogen"; then
	exit 0
fi

cat >> $SUSCRIPT << EOL

# Restore wallpaper state
exec nitrogen --restore
EOL

