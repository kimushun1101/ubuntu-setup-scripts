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

# Move away from UNC path (very important for cmd.exe)
cd /mnt/c/

# Detect Windows username (UTF-8)
WINUSER=$(cmd.exe /c "chcp 65001 > nul & echo %USERNAME%" | tr -d '\r')
WINHOME=$(wslpath "$(cmd.exe /c "chcp 65001 > nul & echo %USERPROFILE%" | tr -d '\r')")

WINSSH="$WINHOME/.ssh"

echo "Detected Windows user: \"$WINUSER\""
echo "Windows .ssh directory: $WINSSH"

mkdir -p "$WINSSH"

echo "Copying SSH keys..."
cp ~/.ssh/id_ed25519 "$WINSSH/"
echo "SSH keys copied."

# UTF-8 PowerShell + quoted username and path
echo "Setting permissions on Windows..."
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -Command \
  "[Console]::OutputEncoding=[System.Text.Encoding]::UTF8; icacls \"C:\Users\\$WINUSER\.ssh\id_ed25519\" /inheritance:r /grant:r \"$WINUSER:(R,W)\" /grant:r \"SYSTEM:(R,W)\"" > /dev/null

echo "Done!"
echo "Next step on Windows (PowerShell):"
echo '  ssh-add $env:USERPROFILE\.ssh\id_ed25519'
