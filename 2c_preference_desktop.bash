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

# GNOME / X11 依存の設定: 時計表示・キーボード設定（Caps→Ctrl、xkb keymap）
# X11/GNOME が無い環境（CLI/headless/コンテナ）では実行しないこと

cd `dirname $0`

# time setting
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
# gsettings set org.gnome.desktop.interface clock-show-seconds true

# keyboard settings
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
xkb_command="xkbcomp -I$(pwd)/config/xkb $(pwd)/config/xkb/keymap/mykbd $DISPLAY 2> /dev/null"
profile_path="$HOME/.profile"
if ! grep -q "$xkb_command" "$profile_path"; then
  echo "$xkb_command" >> "$profile_path"
fi
bashrc_path="$HOME/.bashrc"
if ! grep -q "$xkb_command" "$bashrc_path"; then
  echo "$xkb_command" >> "$bashrc_path"
fi
source $bashrc_path

echo -e "\033[32mDesktop preference setting is complete!\033[m"
