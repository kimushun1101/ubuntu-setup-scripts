#!/bin/bash

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
    [y]*)
      git config --global user.name "$USER_NAME"
      git config --global user.email "$USER_EMAIL"
      git config --global core.editor vim.tiny
      break ;;
    [n]*)
      break ;;
    [c]*)
      echo "---"
      read -p "user.name  : " USER_NAME
      read -p "user.email : " USER_EMAIL;;
    *);;
  esac
done

# set ssh key
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

echo "GitHub configuration is complete!"
