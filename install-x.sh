#!/bin/sh
sudo apt-get install xorg xserver-xorg
sudo apt-get install --no-install-recommends i3 plasma-desktop gtk3-engines-breeze kde-config-gtk-style kde-config-screenlocker kde-config-sddm kde-style-oxygen-qt5 kwin-x11 kwrited systemsettings user-manager libpam-kwallet5 kinfocenter khotkeys konsole
sudo usermod -a -G $(logname) video
cp ~/.xinitrc ~/.xinitrc-bak
cp xinitrc ~/.xinitrc

