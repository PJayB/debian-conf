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

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

cp -nv config-templates/bash_aliases ~/.bash_aliases
cp -nv config-templates/nanorc ~/.nanorc
cp -nv config-templates/gitconfig ~/.gitconfig
cp -nv config-templates/gdbinit ~/.gdbinit
cp -nv config-templates/ssh-config ~/.ssh/config
cp -nv config-templates/tmux.conf ~/.tmux.conf

sudo cp -v config-templates/lynx.cfg /etc/lynx.cfg

if ! grep -E 'basics-setup' ~/.bashrc; then
    echo "Configuring bashrc"
    cat config-templates/bashrc >> ~/.bashrc
else
    echo "bashrc already configured"
fi

. ~/.bashrc
