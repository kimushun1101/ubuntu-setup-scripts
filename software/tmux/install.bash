#!/bin/bash -eu
echo -e "\033[32mInstall : tmux\033[m"
sudo snap install tmux --classic
ln -sf $(pwd)/tmux.conf ~/.tmux.conf
