#!/bin/sh
set -e

sudo apt-get install -y \
    zsh \
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

if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Getting tmux plugins..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

#cp -nv config-templates/bash_aliases ~/.bash_aliases
cp -nv config-templates/nanorc ~/.nanorc
cp -nv config-templates/gitconfig ~/.gitconfig
cp -nv config-templates/gdbinit ~/.gdbinit
cp -nv config-templates/ssh-config ~/.ssh/config
cp -nv config-templates/tmux.conf ~/.tmux.conf

sudo cp -v config-templates/lynx.cfg /etc/lynx.cfg

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Getting Oh-My-Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

touch ~/.bashrc
touch ~/.zshrc

if [ ! -f ~/.bash_aliases ]; then
    echo "#!/bin/bash" > ~/.bash_aliases
    cat config-templates/aliases >> ~/.bash_aliases
fi
if ! grep -Eq 'basics-setup' ~/.bashrc; then
    echo "Configuring bashrc"
    cat config-templates/bashrc >> ~/.bashrc
else
    echo "bashrc already configured"
fi
if ! grep -Eq 'basics-setup' ~/.zshrc; then
    echo "Configuring zshrc"
    cat config-templates/zshrc >> ~/.zshrc
    cat config-templates/aliases >> ~/.zshrc
else
    echo "zshrc already configured"
fi

if [ "$SHELL" = "/bin/bash" ]; then
    . ~/.bashrc
elif [ "$SHELL" = "/bin/zsh" ]; then
    . ~/.zshrc
fi

