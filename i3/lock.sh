#!/bin/bash
wpaper=$(gsettings get org.gnome.desktop.background picture-uri | sed -nr "s|'file://(.*)'|\1|p")
if [ -f "$wpaper" ]; then
    wpaper=("--image=$wpaper" "--tiling")
fi
i3lock --color=0C2D4A --show-failed-attempts --ignore-empty-password "${wpaper[@]}"
