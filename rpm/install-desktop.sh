#/bin/bash
#sudo yum -y groups install "GNOME Desktop"
#sudo systemctl set-default graphical.target
#sudo systemctl set-default multi-user.target
sudo dnf install -y cinnamon
sudo (echo "allowed_users=anybody" >> /etc/X11/Xwrapper.config)
cp -vn config-templates/xinitrc ~/.xinitrc

