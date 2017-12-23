#!/bin/sh
set -e

sudo apt-get install -y \
	apt-file \
	mercurial python-pip \
	git linux-tools-common \
	wget curl ssh \
	gdb binutils auditd \
    valgrind kcachegrind \
    linux-tools-$(uname -r) linux-cloud-tools-$(uname -r) \
	gcc g++ make cmake build-essential \
	nano tweak apcalc \
	zip p7zip-full \
	tmux screen \
	ddate lolcat cmatrix cowsay toilet espeak \
    htop

cp -nv config-templates/bash_aliases ~/.bash_aliases
cp -nv config-templates/nanorc ~/.nanorc
cp -nv config-templates/gitconfig ~/.gitconfig
cp -nv config-templates/gdbinit ~/.gdbinit

if ! grep -q "lolcat" ~/.bashrc; then
	echo "(ddate && fortune) | lolcat" >> ~/.bashrc
fi

