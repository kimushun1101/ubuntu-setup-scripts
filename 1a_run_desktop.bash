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
# 不要なソフトはコメントアウトしてください

cd `dirname $0`

sudo apt update

# Preference
./2a_preference_common.bash
./2b_preference_systemd.bash
./2c_preference_desktop.bash
./2d_preference_mozc.bash

# Software
./software/uv/install.bash
./software/claude-code/install.bash
./software/codex/install.bash
./software/code/install.bash
./software/docker/install.bash
./software/tmux/install.bash
./software/brave-browser/install.bash
# ./software/google-chrome-stable/install.bash
# ./software/terminator/install.bash
# ./software/ulauncher/install.bash

echo -e "\033[32mDesktop setup is complete!\033[m"
