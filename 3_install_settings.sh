#!/bin/sh
cd `dirname $0`

LANG=C xdg-user-dirs-gtk-update

APT_INSTALL=0
command -v curl  > /dev/null 2>&1 || APT_INSTALL=1
command -v terminator > /dev/null 2>&1 || APT_INSTALL=1
if [ $APT_INSTALL -eq 1 ]; then
  sudo apt update
  sudo apt install -y curl terminator
fi

# Google Chrome
if ! command -v google-chrome-stable &> /dev/null; then
  curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb
  sudo apt install ./chrome.deb
  rm -f chrome.deb
fi

# VS Code
if ! command -v code &> /dev/null; then
  curl -L curl -L http://go.microsoft.com/fwlink/?LinkID=760868 -o code.deb
  sudo apt install ./code.deb
  rm -f code.deb
fi

# Docker
if ! command -v docker &> /dev/null; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  rm -f get-docker.sh
fi

# Terminator
mkdir -p ~/.config/terminator
cp -f terminator_config ~/.config/terminator/config

# time setting
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
# gsettings set org.gnome.desktop.interface clock-show-seconds true
sudo timedatectl set-local-rtc true

# config files
mkdir ~/.vimbackup
ln -s $(pwd)/vimrc ~/.vimrc
ln -s $(pwd)/bash_aliases ~/.bash_aliases
ln -s $(pwd)/xkb ~/.xkb

# keyboard settings
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
echo "xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY" >> ~/.bashrc
echo "clear" >> ~/.bashrc
source ~/.bashrc
