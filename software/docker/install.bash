#!/bin/bash -eu
echo -e "\033[32mInstall : Docker CLI\033[m"
if ! command -v curl &> /dev/null; then
  sudo apt install -y curl
fi
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm -f get-docker.sh
