#!/bin/bash
#
# Copy this to /lib/systemd/system-sleep and make sure it's executable
#

# "post" is the /lib/systemd/system-sleep signal that the PC has resumed from sleep
# "resume" is the /usr/lib/pm-utils/sleep.d signal that the PC has resumed from sleep
if [ "$1" != "post" ] && [ "$1" != "resume" ]; then
  exit 0
fi

# Restart chrome GPU processes after PC wakes up
/home/pete/setup-scripts/tools/restore-chrome.sh

