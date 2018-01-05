#!/bin/sh
set -e

PKGMAN=$(./package-manager.sh)
if [ "$PKGMAN" = "" ]; then
    echo "Unknown package manager."
    exit 1
fi

SHARED_PACKAGES="zsh git wget curl tmux screen mercurial python-pip gdb binutils gcc g++ make cmake nano zip valgrind"
#PERF_PACKAGES="auditd kcachegrind"
DUMB_PACKAGES="ddate lolcat cmatrix cowsay toilet espeak"
APT_PACKAGES="$SHARED_PACKAGES apt-file linux-tools-common linux-tools-$(uname -r) linux-cloud-tools-$(uname -r) build-essential tweak apcalc htop $DUMB_PACKAGES"
RPM_PACKAGES="p7zip-plugins perf"
YUM_PACKAGES="$SHARED_PACKAGES $RPM_PACKAGES p7zip-full epel-release"
DNF_PACKAGES="$SHARED_PACKAGES $RPM_PACKAGES p7zip"

if [ "$PKGMAN" = "apt-get" ]; then
    sudo $PKGMAN update
    sudo $PKGMAN install -y $APT_PACKAGES
elif [ "$PKGMAN" = "yum" ]; then
    sudo $PKGMAN install -y $YUM_PACKAGES
    sudo $PKGMAN groupinstall -y 'Development Tools'
elif ["$PKGMAN" = "dnf" ]; then
    sudo $PKGMAN install -y $DNF_PACKAGES
    sudo $PKGMAN groupinstall -y 'Development Tools'
else
    echo "$PKGMAN-based distros aren't supported."
    exit 1
fi
