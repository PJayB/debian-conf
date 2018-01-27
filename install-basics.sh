#!/bin/sh
set -e

PKGMAN=$(./package-manager.sh)
if [ "$PKGMAN" = "" ]; then
    echo "Unknown package manager."
    exit 1
fi

# CentOS has a frankly ANCIENT mercurial installation
if [ "$PKGMAN" = "yum" ]; then
sudo sh -c 'cat > /etc/yum.repos.d/mercurial.repo' <<- EOM
[mercurial]
name=Mercurial packages for CentOS7
# baseurl
baseurl=https://www.mercurial-scm.org/release/centos\$releasever
skip_if_unavailable=True
enabled=1
gpgcheck=0
EOM
fi

# These packages don't exist on WSL
LINUX_TOOLS_PACKAGES=
if ! uname -r | grep "Microsoft"; then
	LINUX_TOOLS_PACKAGES="linux-tools-$(uname -r) linux-cloud-tools-$(uname -r)"
fi


SHARED_PACKAGES="git wget curl tmux screen python-pip mercurial gdb binutils gcc g++ make cmake nano zip valgrind openvpn xclip openssh-server"
#PERF_PACKAGES="auditd kcachegrind"
DUMB_PACKAGES="ddate lolcat cmatrix cowsay toilet espeak"
APT_PACKAGES="$SHARED_PACKAGES apt-file linux-tools-common $LINUX_TOOLS_PACKAGES build-essential tweak apcalc htop auditd mercurial-keyring resolvconf $DUMB_PACKAGES"
RPM_PACKAGES="p7zip-plugins perf"
YUM_PACKAGES="$SHARED_PACKAGES $RPM_PACKAGES p7zip-full epel-release"
DNF_PACKAGES="$SHARED_PACKAGES $RPM_PACKAGES p7zip"

if [ "$PKGMAN" = "apt-get" ]; then
    sudo $PKGMAN update
    sudo $PKGMAN install -y $APT_PACKAGES
elif [ "$PKGMAN" = "yum" ]; then
    sudo $PKGMAN install -y $YUM_PACKAGES
    sudo $PKGMAN groupinstall -y 'Development Tools'
elif [ "$PKGMAN" = "dnf" ]; then
    sudo $PKGMAN install -y $DNF_PACKAGES
    sudo $PKGMAN groupinstall -y 'Development Tools'
else
    echo "$PKGMAN-based distros aren't supported."
    exit 1
fi

pip install --upgrade pip
pip install mercurial_keyring

# Set up WSL-specific stuff
if uname -r | grep "Microsoft"; then
    sudo apt-get purge -y openssh-server
    sudo apt-get install -y openssh-server
    echo "PermitRootLogin no
AllowUsers $USER
PasswordAuthentication yes
UsePrivilegeSeparation no" | sudo tee -a /etc/ssh/sshd_config > /dev/null
    sudo service ssh --full-restart
fi

echo "Done."

