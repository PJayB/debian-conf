#!/bin/bash
SCRIPT_NAME="disable-vc-switch.sh"
SCRIPT_SRC="config-templates/$SCRIPT_NAME"
SCRIPT_DST="/usr/bin/$SCRIPT_NAME"
SERVICE_NAME="disable-vc-switch.service"
SERVICE_SRC="config-templates/$SERVICE_NAME"
SERVICE_DST="/etc/systemd/system/$SERVICE_NAME"

sudo cp -v "$SCRIPT_SRC" "$SCRIPT_DST"
sudo chmod +x "$SCRIPT_DST"
sudo chown root:root "$SCRIPT_DST"

sudo cp -v "$SERVICE_SRC" "$SERVICE_DST"
sudo chmod +x "$SERVICE_DST"
sudo chown root:root "$SERVICE_DST"

sudo systemctl enable disable-vc-switch

