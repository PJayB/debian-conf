#!/bin/sh
set -e

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

[ -e ~/.nanorc ] || ln -sv $(pwd)/config-templates/nanorc ~/.nanorc
[ -e ~/.gitconfig ] || ln -sv $(pwd)/config-templates/gitconfig ~/.gitconfig
[ -e ~/.gdbinit ] || ln -sv $(pwd)/config-templates/gdbinit ~/.gdbinit
[ -e ~/.tmux.conf ] || ln -sv $(pwd)/config-templates/tmux.conf ~/.tmux.conf

#if [ "$TERM" != "cygwin" ]; then
#    sudo cp -v config-templates/lynx.cfg /etc/lynx.cfg
#fi

touch ~/.bashrc

if ! grep -Eq 'basics-setup' ~/.bashrc; then
    echo "Configuring bashrc"
    echo "# basics-setup" >> ~/.bashrc
    echo ". $(pwd)/config-templates/bashrc" >> ~/.bashrc
    echo ". $(pwd)/config-templates/aliases" >> ~/.bashrc

    tools_folder="$(pwd)/tools"
    echo "PATH=\$PATH:$tools_folder" >> ~/.bashrc
else
    echo "bashrc already configured"
fi

if [ ! -f ~/.ssh/config ]; then
    echo "Don't forget to set up your ssh keys!"
fi

if [ "$(uname -s)" == "Darwin" ]; then
    cp -v darwin/inputrc ~/.inputrc
    cp -v darwin/nanorc ~/.nanorc
    CODEPATH="$HOME/Library/Application Support/Code/User"
else
    CODEPATH="$HOME/.config/Code/User"
    gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
    gsettings set org.gnome.desktop.wm.preferences button-layout "':minimize,maximize,close'"
    gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "'<Super>t'"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
    gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"

    dconf load /org/gnome/terminal/legacy/profiles:/ < config-templates/gnome-terminal-profiles.dconf
fi

mkdir -vp "$CODEPATH"
cp -vnr $(pwd)/config-templates/vscode/* "$CODEPATH/"

if [ "$SHELL" = "/bin/bash" ]; then
    . ~/.bashrc
elif [ "$SHELL" = "/bin/zsh" ]; then
    . ~/.zshrc
fi
