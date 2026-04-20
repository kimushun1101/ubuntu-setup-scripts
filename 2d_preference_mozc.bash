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

# Mozc（日本語 IME）のキー設定
# GUI（DISPLAY）が必要。mozc_tool の設定ダイアログを手動で閉じる必要あり

cd `dirname $0`

# mozc settings
sudo apt install mozc-utils-gui -y
while true; do
  read -p "Do you import Mozc Property? (y:Yes/n:No): " yn
  case "$yn" in
    [yY]*)
      echo "キー設定の選択 → 編集... → 編集 → インポート... → keymap_for_mozc.txt(一時的にホームディレクトリにコピーされています)"
      ln -sf $(pwd)/config/keymap_for_mozc.txt ~/keymap_for_mozc.txt
      /usr/lib/mozc/mozc_tool --mode=config_dialog
      rm -f ~/keymap_for_mozc.txt
      break;;
    [nN]*) echo "Mozc setting was skipped."; break ;;
    *);;
  esac
done

echo -e "\033[32mMozc preference setting is complete!\033[m"
