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

# Software install
APT_INSTALL=0
command -v git  > /dev/null 2>&1 || APT_INSTALL=1
command -v xsel > /dev/null 2>&1 || APT_INSTALL=1
if [ $APT_INSTALL -eq 1 ]; then
  sudo apt update
  sudo apt install git xsel -y
fi

# set user.name and user.email
USER_NAME="Shunsuke Kimura"
USER_EMAIL="kimushun1101@gmail.com"
echo "user.name  : $USER_NAME"
echo "user.email : $USER_EMAIL"
while true; do
  read -p "Do you set at the above user.name and user.email? (y:Yes/n:No/c:Change): " ync
  case "$ync" in 
    [yY]*)
      git config --global user.name "$USER_NAME"
      git config --global user.email "$USER_EMAIL"
      git config --global core.editor vim.tiny
      break ;;
    [nN]*)
      break ;;
    [cC]*)
      echo "---"
      read -p "user.name  : " USER_NAME
      read -p "user.email : " USER_EMAIL;;
    *);;
  esac
done

# generate ssh key
if [ ! -e ~/.ssh/id_ed25519 ]; then
  cd ~/.ssh
  ssh-keygen -t ed25519
fi

while true; do
  if ssh -T git@github.com 2>&1 | grep -Eq "You.*successfully authenticated"; then
    break
  else
    ssh -T git@github.com
    echo "Check your ssh key settings."
    echo "Open the GitHub SSH settings."
    xdg-open https://github.com/settings/ssh > /dev/null 2>&1
    echo "Copy id_ed25519.pub to your clipboard."
    cat ~/.ssh/id_ed25519.pub | xsel --clipboard --input
    read -p  "Upload public key, then HIT ENTER:" continue
  fi
done

echo -e "\033[32mGitHub configuration is complete!\033[m"

