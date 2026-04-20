#!/bin/bash -eu
echo -e "\033[32mInstall : Terminator\033[m"
sudo apt install -y terminator
mkdir -p ~/.config/terminator
ln -sf $(pwd)/software/terminator/config ~/.config/terminator/config
