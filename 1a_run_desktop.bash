#!/bin/bash -eu

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

# ネイティブ Ubuntu-Desktop 用セットアップ
# 全項目を対話選択 (ASSUME_YES=1 で全 default 採用)

cd `dirname $0`

source ./software/_prompt_lib.bash

echo
echo "=== セットアップ項目選択 (Enter でデフォルト) ==="

# Preference
ask_step 2a-common  ./2a_preference_common.bash  y "vim/.bashrc/xdg ホーム英語化"
ask_step 2b-systemd ./2b_preference_systemd.bash y "デュアルブート時計ずれ対策"
ask_step 2c-desktop ./2c_preference_desktop.bash y "GNOME 時計/キーボード"
ask_step 2d-mozc    ./2d_preference_mozc.bash    y "Mozc IME 設定"

# Software
ask_pkg uv          y "Python パッケージマネージャ"
ask_pkg gh          y "GitHub CLI"
ask_pkg claude-code y
ask_pkg nodejs      y "Node.js LTS (via nvm)"
ask_pkg codex       y "OpenAI Codex CLI"
ask_pkg code        y "VS Code"
ask_pkg docker      y
ask_pkg tmux        y
ask_pkg hackgen     y "HackGen NF フォント"
ask_pkg biz-ud      y "BIZ UD ゴシック+明朝 (等幅+プロポーショナル)"

ask_pkg brave-browser y "推奨ブラウザ"
if [ "${_STEP_CHOICE[brave-browser]}" = "n" ]; then
  ask_pkg google-chrome-stable y "代替ブラウザ"
fi

ask_pkg ghostty y "推奨ターミナル"
if [ "${_STEP_CHOICE[ghostty]}" = "n" ]; then
  ask_pkg terminator y "代替ターミナル"
fi

ask_pkg ulauncher n "アプリランチャー"

confirm_or_abort

sudo apt update

if run_all; then
  echo -e "\033[32mDesktop setup is complete!\033[m"
else
  echo -e "\033[33mDesktop setup finished with some failures. See above.\033[m"
  exit 1
fi
