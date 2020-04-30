#!/bin/bash

if [ "$(uname -s)" == "Darwin" ]; then
    echo "brew"
else
    declare -A osInfo;
    osInfo[/etc/redhat-release]=yum
    osInfo[/etc/arch-release]=pacman
    osInfo[/etc/gentoo-release]=emerge
    osInfo[/etc/SuSE-release]=zypp
    osInfo[/etc/debian_version]=apt-get
    osInfo[/etc/fedora-release]=dnf

    packageMgr=
    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            packageMgr=${osInfo[$f]}
        fi
    done
    echo $packageMgr
fi
