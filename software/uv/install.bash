#!/bin/bash -eu
echo -e "\033[32mInstall : uv (Python package manager)\033[m"
if ! command -v curl &> /dev/null; then
  sudo apt install -y curl
fi
curl -LsSf https://astral.sh/uv/install.sh | sh
