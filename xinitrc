#!/bin/bash

if [[ "$WM" == "kde" ]]; then
	exec startkde
elif [[ "$WM" == "i3" ]]; then
	exec i3
else
	echo "Choose a window manager! kde or i3"
fi

