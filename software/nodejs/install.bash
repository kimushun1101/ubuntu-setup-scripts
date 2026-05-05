#!/bin/bash -e
# Node.js LTS を nvm 経由でホーム配下にインストール
# 共有サーバ / 非 sudo 環境でも /usr/local を汚さず使える
# Reference: https://github.com/nvm-sh/nvm
#
# 注: set -u は nvm.sh 側で unbound variable に触れる箇所があるため使わない

echo -e "\033[32mInstall : Node.js LTS (via nvm)\033[m"

NVM_VERSION="v0.40.1"
export NVM_DIR="$HOME/.nvm"

if ! command -v curl &> /dev/null; then
  sudo apt install -y curl
fi

if [ ! -s "$NVM_DIR/nvm.sh" ]; then
  curl -fsSL "https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh" | bash
fi

# 現セッション内で nvm をロード (後続の software/<x>/install.bash から見えるように)
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"

# nvm install/use/alias は冪等 (既にあれば skip)
nvm install --lts
nvm use --lts
nvm alias default 'lts/*'

echo "node: $(node -v) / npm: $(npm -v)"
