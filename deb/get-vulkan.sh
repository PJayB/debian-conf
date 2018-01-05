#!/bin/bash
sudo apt-get install -y graphviz libglm-dev graphviz libxcb-dri3-0 libxcb-present0 libpciaccess0 cmake \
libpng-dev libxcb-keysyms1-dev libxcb-dri3-dev libx11-dev libmirclient-dev libwayland-dev libxrandr-dev \
git libpython2.7 wget

xdg-open https://vulkan.lunarg.com/sdk/home &
xdg-open https://vulkan.lunarg.com/doc/sdk/1.0.65.0/linux/getting_started.html
