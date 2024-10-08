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

read -p "Do you delete files made by 2_set_preference.bash? (y:Yes/n:No): " yn
case "$yn" in [yY]*) ;; *) echo "Abort." ; exit ;; esac

gsettings reset org.gnome.desktop.input-sources xkb-options
sed -i "/xkbcomp/d" "$HOME/.bashrc"
sed -i "/xkbcomp/d" "$HOME/.profile"
rm -rf ~/.vimbackup
rm -rf ~/.vimrc
rm -rf ~/.bash_aliases
rm -rf ~/.config/terminator

echo -e "\033[32mConfig was deleted.\033[m"
