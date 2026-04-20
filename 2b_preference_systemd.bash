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

# systemd 依存の設定: デュアルブート時の時刻ずれ対策
# systemd が無効な環境（コンテナ・WSL2 等）では実行しないこと

cd `dirname $0`

# time setting for dual boot
timedatectl set-local-rtc true

echo -e "\033[32mSystemd preference setting is complete!\033[m"
