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

software_list=(\
"code" \
"docker" \
# "google-chrome-stable" \
"terminator" \
"ulauncher" \
)

echo -e "\e[33mThe following software will be installed.\e[0m"
for software in "${software_list[@]}"; do
  echo -e "\033[33m$software\033[m"
done

while true; do
  read -p "Do you install them? (y:Yes/n:No): " yn
  case "$yn" in
    [yY]*) break;;
    [nN]*) echo -e "\033[31mInstallation has been canceled.\033[m"; exit 0 ;;
    *);;
  esac
done

sudo apt update

for software in "${software_list[@]}"; do
  if ! command -v $software &> /dev/null; then
    bash "./software/$software/install.bash"
  else
    echo -e "\033[33m$software is already installed.\033[m"
  fi
done

echo -e "\033[32mSoftware installation is complete!\033[m"
