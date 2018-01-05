#!/bin/bash
sudo $(./package-manager.sh) install -y vagrant virtualbox
vagrant plugin install vagrant-vbguest
if [ ! -d ~/vagrants ]; then
    git clone git@work.bitbucket.org:petelewis-unity3d/vagrants.git ~/vagrants
fi
