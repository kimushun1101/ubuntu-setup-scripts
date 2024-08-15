#!/bin/bash -eu
echo -e "\033[32mInstall : Ulauncher\033[m"
sudo add-apt-repository universe -y
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt update
sudo apt install ulauncher xdotool -y
ln -sf $(pwd)/ulauncher/config ~/.config/ulauncher
