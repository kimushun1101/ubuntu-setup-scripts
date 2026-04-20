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

cd `dirname $0`

sudo apt update

# Preference
./2a_preference_common.bash

# Software
./software/uv/install.bash
./software/gh/install.bash
./software/claude-code/install.bash
./software/codex/install.bash
./software/docker/install.bash
./software/tmux/install.bash

echo -e "\033[32mServer setup is complete!\033[m"
