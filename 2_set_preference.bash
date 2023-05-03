#!/bin/bash

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

cd `dirname $0`

# home directory in English
LANG=C xdg-user-dirs-gtk-update

# config files
mkdir -p ~/.vimbackup
ln -sf $(pwd)/config/vimrc ~/.vimrc
ln -sf $(pwd)/config/bash_aliases ~/.bash_aliases

# time setting
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
# gsettings set org.gnome.desktop.interface clock-show-seconds true
timedatectl set-local-rtc true

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

# mozc settings
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

echo -e "\033[32mPreference setting is complete!\033[m"
