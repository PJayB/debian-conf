#!/bin/sh
set -e

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

[ -e ~/.nanorc ] || ln -s $(pwd)/config-templates/nanorc ~/.nanorc
[ -e ~/.gitconfig ] || ln -s $(pwd)/config-templates/gitconfig ~/.gitconfig
[ -e ~/.gdbinit ] || ln -s $(pwd)/config-templates/gdbinit ~/.gdbinit
[ -e ~/.tmux.conf ] || ln -s $(pwd)/config-templates/tmux.conf ~/.tmux.conf

if [ "$TERM" != "cygwin" ]; then
    sudo cp -v config-templates/lynx.cfg /etc/lynx.cfg
fi

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

#if [ "$TERM" != "cygwin" ]; then
#    echo "If you want to change default shells, use \"chsh -s /path/to/shell\""
#    cat /etc/shells
#fi

if [ "$SHELL" = "/bin/bash" ]; then
    . ~/.bashrc
elif [ "$SHELL" = "/bin/zsh" ]; then
    . ~/.zshrc
fi

gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
gsettings set org.gnome.desktop.wm.preferences button-layout "':minimize,maximize,close'"
gsettings set org.gnome.settings-daemon.plugins.media-keys terminal "'<Super>t'"
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"

dconf load /org/gnome/terminal/legacy/profiles:/ < config-templates/gnome-terminal-profiles.dconf

