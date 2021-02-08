#!/bin/bash
PATTERN=$1
DEVFILE=~/.config/i3/pulse-device

if [ "$PATTERN" != "" ]; then
    SINKS=$(pactl list sinks short | grep "$PATTERN" | awk '{print $2}')
else
    SINKS=$(pactl list sinks short | awk '{print $2}')
fi

THESINK=

i=0
for sink in $SINKS; do
    echo "$sink"
    THESINK=$sink
    i=$(expr $i + 1)
done

if [[ $i > 1 ]]; then
    echo "Multiple devices found ($i). Filter using pulse-setup.sh <pattern>."
    exit 1
elif [[ $i = 0 ]]; then
    echo "No pulse audio devices found. Check the output of 'pacmd list-sinks'."
    exit 1
else
    echo "Configuring $THESINK"
    echo "$THESINK" > $DEVFILE

    i3statusconf="$HOME/.config/i3status/config"
    if [ -f "$i3statusconf" ]; then
      cp "$i3statusconf" "$i3statusconf.bak"
      sed -r "s/\"pulse:.*\"/\"pulse:$THESINK\"/g" "$i3statusconf.bak" > "$i3statusconf"
    fi
fi

i3-msg restart
