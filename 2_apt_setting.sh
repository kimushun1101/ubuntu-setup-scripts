LANG=C xdg-user-dirs-gtk-update

sudo sed -i.bak -e 's|http://archive|http://jp.archive|' /etc/apt/sources.list
sudo apt update
sudo apt upgrade -y
sudo apt autoremove -y
