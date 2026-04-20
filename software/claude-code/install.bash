#!/bin/bash -eu
echo -e "\033[32mInstall : Claude Code\033[m"
if ! command -v curl &> /dev/null; then
  sudo apt install -y curl
fi
curl -fsSL https://claude.ai/install.sh | bash
