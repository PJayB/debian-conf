#!/bin/bash
sudo apt install nitrogen
nitrogen /usr/share/backgrounds

SUSCRIPT=~/.config/i3/custom-startup.sh

if ! grep -q "nitrogen" $SUSCRIPT; then
  cat >> $SUSCRIPT << EOL
fi

chmod +x $SUSCRIPT

# Restore wallpaper state
exec nitrogen --restore
EOL

