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

# One-shot installer for Ubuntu Desktop:
#   curl -fsSL https://raw.githubusercontent.com/kimushun1101/ubuntu-setup-scripts/main/install/desktop.bash | bash

sudo apt update
sudo apt install -y git
REPO="$HOME/.ubuntu-setup-scripts"
if [ ! -d "$REPO" ]; then
  git clone https://github.com/kimushun1101/ubuntu-setup-scripts.git "$REPO"
else
  echo "$REPO already exists. Skipping clone."
fi
cd "$REPO"
./1a_run_desktop.bash
