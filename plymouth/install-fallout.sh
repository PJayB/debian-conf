#!/bin/sh
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/fallout 100
sudo update-initramfs -u

