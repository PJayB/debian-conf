#!/bin/bash
sudo apt install -y vagrant virtualbox
if [ ! -d ~/vagrants ]; then
    git clone git@work.bitbucket.org:petelewis-unity3d/vagrants.git ~/vagrants
fi
