#!/bin/bash

error() {
    notify-send "$*"
    echo "$*" >& 2
    exit 1
}

f="$(mktemp).png"

echo "Writing screenshot to $f..."

gnome-screenshot -f "$f" "$@" || error "Screenshot failed"

while ! file "$f" | grep -q "PNG image data" ; do sleep 0.2 ; done

xdg-open "$f" || error "Failed to open screenshot"

