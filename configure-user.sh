#!/bin/sh
set -e

if [ ! -d ~/.ssh ]; then
    mkdir ~/.ssh
fi

cp -nv config-templates/nanorc ~/.nanorc
cp -nv config-templates/gitconfig ~/.gitconfig
cp -nv config-templates/gdbinit ~/.gdbinit
cp -nv config-templates/tmux.conf ~/.tmux.conf

if [ "$TERM" != "cygwin" ]; then
    sudo cp -v config-templates/lynx.cfg /etc/lynx.cfg
fi

touch ~/.bashrc

if ! grep -Eq 'basics-setup' ~/.bashrc; then
    echo "Configuring bashrc"
    cat config-templates/bashrc >> ~/.bashrc

    # If bashrc expects a bash_aliases file, we should provide one
    # Else, simply inline aliases into bashrc
    if grep -Eq '\.bash_aliases' ~/.bashrc; then
        if [ ! -f ~/.bash_aliases ]; then
            echo "#!/bin/bash" > ~/.bash_aliases
        fi
        cat config-templates/aliases >> ~/.bash_aliases
    else
        cat config-templates/aliases >> ~/.bashrc
    fi
else
    echo "bashrc already configured"
fi

if [ ! -f ~/.ssh/config ]; then
    echo "Don't forget to set up your ssh keys!"
fi

if [ "$TERM" != "cygwin" ]; then
    echo "If you want to change default shells, use \"chsh -s /path/to/shell\""
    cat /etc/shells
fi

if [ "$SHELL" = "/bin/bash" ]; then
    . ~/.bashrc
elif [ "$SHELL" = "/bin/zsh" ]; then
    . ~/.zshrc
fi

gsettings set org.gnome.desktop.interface gtk-enable-primary-paste false
