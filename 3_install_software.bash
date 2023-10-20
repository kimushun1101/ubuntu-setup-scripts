#!/bin/bash

# Copyright 2023 Shunsuke Kimura

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cd `dirname $0`

# Terminator
if ! command -v terminator &> /dev/null; then
  sudo apt update
  sudo apt install -y terminator
  mkdir -p ~/.config/terminator
  ln -sf $(pwd)/config/terminator_config ~/.config/terminator/config
fi

# Google Chrome
if ! command -v google-chrome-stable &> /dev/null; then
  curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb
  sudo apt install ./chrome.deb
  rm -f chrome.deb
fi

# VS Code
if ! command -v code &> /dev/null; then
  curl -L http://go.microsoft.com/fwlink/?LinkID=760868 -o code.deb
  sudo apt install ./code.deb
  rm -f code.deb
fi

# Docker
if ! command -v docker &> /dev/null; then
  if ! command -v curl &> /dev/null; then
    sudo apt update
    sudo apt install -y curl
  fi
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  sudo usermod -aG docker $USER
  rm -f get-docker.sh
fi

# Ulauncher
# 
# if ! command -v ulaunder &> /dev/null; then
#   sudo add-apt-repository ppa:agornostal/ulauncher
#   sudo apt update
#   sudo apt install ulauncher xdotool
#   gnome-control-center keyboard &
#   echo "Optional : set ulauncher-toggle at Ctrl-Space in keyboard-shortcuts"
#   ln -sf $(pwd)/config/ulauncher ~/.config/ulauncher
# fi

echo -e "\033[32mSoftware installation is complete!\033[m"
