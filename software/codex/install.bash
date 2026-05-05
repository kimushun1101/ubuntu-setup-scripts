#!/bin/bash -e
# 注: set -u は nvm.sh 側で unbound variable に触れるので使わない
echo -e "\033[32mInstall : OpenAI Codex CLI\033[m"

# nvm 経由で Node.js を入れている場合、本セッションでは PATH にまだ通っていない
# software/nodejs/install.bash が同じ run_all 内で先に走ったケースを含めて nvm.sh を source する
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  # shellcheck disable=SC1091
  . "$NVM_DIR/nvm.sh"
fi

if ! command -v npm &> /dev/null; then
  echo -e "\033[31mnpm not found. nodejs を先に選択してインストールしてください (software/nodejs/install.bash)\033[m"
  exit 1
fi

npm install -g @openai/codex
