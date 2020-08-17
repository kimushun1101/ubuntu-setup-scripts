#!/bin/sh
read -p "Did you change user.name and user.email? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort." ; exit ;; esac

git config --global user.name "Shunsuke Kimura"
git config --global user.email "kimushun1101@gmail.com"

if [ ! -e ~/.ssh/id_rsa ]; then
  cd ~/.ssh
  ssh-keygen -t rsa
fi

source ~/.bashrc
cat ~/.ssh/id_rsa.pub | pbcopy
xdg-open https://github.com/settings/ssh
read -p "Upload public key, then HIT ENTER: \n you can use 'cat ~/.ssh/id_rsa.pub | pbcopy' " continue
ssh -T git@github.com
