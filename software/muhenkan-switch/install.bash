#!/bin/bash -eu
# Install muhenkan-switch (無変換キー同時押しショートカットツール)
# Reference: https://github.com/kimushun1101/muhenkan-switch
echo -e "\033[32mInstall : muhenkan-switch\033[m"

if ! command -v curl &> /dev/null; then
  sudo apt install -y curl
fi

# 公式ワンライナー: 最新 release を取得して install.sh を実行 (X11 検証済み)
curl -fsSL https://raw.githubusercontent.com/kimushun1101/muhenkan-switch/main/scripts/install/get.sh | sh
