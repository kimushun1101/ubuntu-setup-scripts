#!/bin/bash -eu

# Copyright 2025 Shunsuke Kimura

# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at

#     http://www.apache.org/licenses/LICENSE-2.0

# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# CLI 環境（Ubuntu Server / headless ネイティブ機）用セットアップ
# GUI・systemd-ベースのデュアルブート設定は含まない
# 全項目を対話選択 (ASSUME_YES=1 で全 default 採用)

cd `dirname $0`

source ./software/_prompt_lib.bash

echo
echo "=== セットアップ項目選択 (Enter でデフォルト) ==="

# Preference
ask_step 2a-common ./2a_preference_common.bash y "vim/.bashrc/xdg ホーム英語化"

# Software
ask_pkg uv          y "Python パッケージマネージャ"
ask_pkg gh          y "GitHub CLI"
ask_pkg claude-code y
ask_pkg codex       y "OpenAI Codex CLI"
ask_pkg docker      y
ask_pkg tmux        y

confirm_or_abort

sudo apt update

if run_all; then
  echo -e "\033[32mServer setup is complete!\033[m"
else
  echo -e "\033[33mServer setup finished with some failures. See above.\033[m"
  exit 1
fi
