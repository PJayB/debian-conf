#!/bin/bash
DEVICES=$(xinput --list --short | grep -e "Razer.*pointer.*$")

while read -r DEVICE; do
	echo Found: $DEVICE
	PTRID=$(echo $DEVICE | grep -o -e "id=[0-9]*" | sed 's/id=//g')
#	echo $PTRID
	xinput --set-prop $PTRID "libinput Accel Speed" -0.9
	xinput --set-prop $PTRID "Coordinate Transformation Matrix" 0.6 0 0 0 0.6 0 0 0 2
done <<< "$DEVICES"



