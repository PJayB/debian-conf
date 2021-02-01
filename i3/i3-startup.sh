#!/bin/bash

# Set the DPI of the display
if [ -f ~/.config/i3/custom-dpi ]; then
    DPI=$(cat ~/.config/i3/custom-dpi)
    echo "Setting DPI to $DPI"
    xrandr --dpi $DPI
fi

# Start pulseaudio
start-pulseaudio-x11

# Start a terminal
i3-msg "workspace 1; layout stacking; exec i3-sensible-terminal;"
#if xrandr --listactivemonitors | grep -qE '^ 1:' ; then
#    i3-msg "workspace 2; layout stacking; exec google-chrome"
#else
#    i3-msg "exec google-chrome"
#fi

# Execute custom scripts
CUSTOMSCRIPT=~/.config/i3/custom-startup.sh
if [ -f $CUSTOMSCRIPT ]; then
    source "$CUSTOMSCRIPT"
fi

