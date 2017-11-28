#!/bin/sh
set -e

sudo apt-get install -y \
	apt-file \
	mercurial python-pip \
	git linux-tools-common \
	wget curl ssh \
	gdb binutils auditd \
	gcc g++ make cmake build-essential \
	nano tweak apcalc \
	zip p7zip-full \
	tmux screen

cp -nv config-templates/bash_aliases ~/.bash_aliases
cp -nv config-templates/nanorc ~/.nanorc
cp -nv config-templates/gitconfig ~/.gitconfig
cp -nv config-templates/gdbinit ~/.gdbinit


