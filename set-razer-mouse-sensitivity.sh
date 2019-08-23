#!/bin/bash
DEVICES=$(xinput --list --short | grep -e "Razer.*pointer.*$")
SENS=0.75
if [ "$1" != "" ]; then
    SENS=$1
fi

while read -r DEVICE; do
	echo Found: $DEVICE
	PTRID=$(echo $DEVICE | grep -o -e "id=[0-9]*" | sed 's/id=//g')
#	echo $PTRID
#	xinput --set-prop $PTRID "libinput Accel Speed" -0.9
    xinput --set-prop $PTRID "Device Accel Velocity Scaling" 3.0
	xinput --set-prop $PTRID "Coordinate Transformation Matrix" $SENS 0 0 0 $SENS 0 0 0 2
done <<< "$DEVICES"



