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

if [ ! -d ~/.tmux/plugins/tpm ]; then
    echo "Getting tmux plugins..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

cp -nv config-templates/nanorc ~/.nanorc
cp -nv config-templates/gitconfig ~/.gitconfig
cp -nv config-templates/gdbinit ~/.gdbinit
cp -nv config-templates/tmux.conf ~/.tmux.conf

sudo cp -v config-templates/lynx.cfg /etc/lynx.cfg

if [ ! -d ~/.oh-my-zsh ]; then
    echo "Getting Oh-My-Zsh..."
    # need to de-fang the default config part of the script
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed -e 's:TEST_CURRENT_SHELL=.*$:exit 0:g')"
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

if [ ! -f ~/.ssh/config ]; then
    echo "Don't forget to set up your ssh keys!"
fi

if [ "$USER" != "vagrant" ]; then
    sudo chsh -s /bin/zsh $USER
    echo "Default shell changed to ZSH. You might want to log out and in again."
fi

if [ "$SHELL" = "/bin/bash" ]; then
    . ~/.bashrc
elif [ "$SHELL" = "/bin/zsh" ]; then
    . ~/.zshrc
fi

#exec /bin/zsh
