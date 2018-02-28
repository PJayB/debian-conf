#!/bin/bash

# Set the DPI of the display
if [ -f ~/.config/i3/custom-dpi ]; then
    DPI=$(cat ~/.config/i3/custom-dpi)
    echo "Setting DPI to $DPI"
    xrandr --dpi $DPI
fi

# Start pulseaudio
start-pulseaudio-x11

# Execute custom scripts
CUSTOMSCRIPT=~/.config/i3/custom-startup.sh
if [ -f $CUSTOMSCRIPT ]; then
    source "$CUSTOMSCRIPT"
fi
