#!/bin/bash -e
# Node.js LTS を nvm 経由でホーム配下にインストール
# 共有サーバ / 非 sudo 環境でも /usr/local を汚さず使える
# Reference: https://github.com/nvm-sh/nvm
#
# 注: set -u は nvm.sh 側で unbound variable に触れる箇所があるため使わない

echo -e "\033[32mInstall : Node.js LTS (via nvm)\033[m"

NVM_VERSION="v0.40.4"
export NVM_DIR="$HOME/.nvm"

if ! command -v curl &> /dev/null; then
  sudo apt install -y curl
fi

# nvm は ~/.npmrc の prefix / globalconfig 設定と非互換で、残っていると `nvm use` が非 0 終了し
# `set -e` で本スクリプトが落ちる。nvm install (DL) より前に検知して案内する。
if [ -f "$HOME/.npmrc" ] && grep -Eq '^[[:space:]]*(prefix|globalconfig)[[:space:]]*=' "$HOME/.npmrc"; then
  echo -e "\033[31m~/.npmrc に prefix / globalconfig 設定があり nvm と非互換です。\033[m" >&2
  echo -e "\033[31m該当行を削除するか、~/.npmrc を退避 (mv ~/.npmrc ~/.npmrc.bak) してから再実行してください。\033[m" >&2
  exit 1
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
