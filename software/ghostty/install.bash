#!/bin/bash -eu
# Install Ghostty terminal emulator from mkasberg/ghostty-ubuntu
# Reference: https://github.com/mkasberg/ghostty-ubuntu
echo -e "\033[32mInstall : Ghostty\033[m"

bash -c "$(curl -fsSL https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh)"

# Ctrl+Alt+T やファイラの「ここで開く」で起動するデフォルトターミナルを Ghostty に切替
sudo update-alternatives --set x-terminal-emulator /usr/bin/ghostty
