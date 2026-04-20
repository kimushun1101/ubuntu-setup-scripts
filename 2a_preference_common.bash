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

# 環境非依存の基本設定: vim / .bash_aliases / ホームディレクトリ英語化

cd `dirname $0`

# config files
sudo apt install -y vim
mkdir -p ~/.vimbackup
ln -sf $(pwd)/config/.vimrc ~/.vimrc
ln -sf $(pwd)/config/bash_aliases ~/.bash_aliases

# home directory in English
LANG=C xdg-user-dirs-update --force

echo -e "\033[32mCommon preference setting is complete!\033[m"
