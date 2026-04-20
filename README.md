[日本語](/README.md) | [English](/README_en.md) | [For me](/doc/setup_github_for_ssh_clone.md)

# Ubuntu setup scripts

Ubuntu 環境（Desktop / Server / WSL2 / Container）向けのセットアップスクリプト集。

## Quick install (curl | bash)

環境ごとに以下を実行するだけでクローン → セットアップ完走まで行う。

### Desktop (native Ubuntu)

```
curl -fsSL https://raw.githubusercontent.com/kimushun1101/ubuntu-setup-scripts/main/install/desktop.bash | bash
```

### Server (CLI / headless)

```
curl -fsSL https://raw.githubusercontent.com/kimushun1101/ubuntu-setup-scripts/main/install/server.bash | bash
```

### WSL2

```
curl -fsSL https://raw.githubusercontent.com/kimushun1101/ubuntu-setup-scripts/main/install/wsl.bash | bash
```

### Container (podman / docker container)

```
curl -fsSL https://raw.githubusercontent.com/kimushun1101/ubuntu-setup-scripts/main/install/container.bash | bash
```

中身を確認してから実行したい場合は、[install/](/install/) のファイルをブラウザで開いてコピペ実行すればよい。

## Manual install

```
sudo apt install git
git clone https://github.com/kimushun1101/ubuntu-setup-scripts.git ~/.ubuntu-setup-scripts
cd ~/.ubuntu-setup-scripts
# 環境に応じて実行:
# ./1a_run_desktop.bash
# ./1b_run_server.bash
# ./1c_run_wsl.bash
# ./1d_run_container.bash
```

## Environment matrix

各エントリーポイントが呼ぶ preference / software の対応:

| 環境 | entry | 2a common | 2b systemd | 2c desktop | 2d mozc | 6 ssh→win |
|---|---|:-:|:-:|:-:|:-:|:-:|
| Desktop   | 1a | ● | ● | ● | ● |   |
| Server    | 1b | ● |   |   |   |   |
| WSL2      | 1c | ● |   |   |   | ● |
| Container | 1d | ● |   |   | ● |   |

Software は `software/<name>/install.bash` を各 `1*_run_*.bash` から個別に呼ぶ。デフォルト構成:

| 環境 | uv | gh | claude-code | codex | code | docker | tmux | brave-browser |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Desktop   | ● | ● | ● | ● | ● | ● | ● | ● |
| Server    | ● | ● | ● | ● |   | ● | ● |   |
| WSL2      | ● | ● | ● | ● |   | ● | ● |   |
| Container | ● | ● | ● | ● |   | ● | ● |   |

`google-chrome-stable` / `terminator` / `ulauncher` は Desktop のみ用意（コメントアウト、必要に応じて有効化）。VS Code の Server/WSL/Container への事前インストールは不要（Remote-SSH / Dev Containers で `~/.vscode-server` が自動配置されるため）。

## Contents

### 1a_run_desktop.bash / 1b_run_server.bash / 1c_run_wsl.bash / 1d_run_container.bash

環境別エントリーポイント。`sudo apt update` → preference スクリプト群 → software インストールの順で実行。

### 2a_preference_common.bash

- vim インストール
- `config/.vimrc`, `config/bash_aliases` へのシンボリックリンク作成
- ホームディレクトリのディレクトリ名を英語に変更

### 2b_preference_systemd.bash

- `timedatectl set-local-rtc true`（Windows とデュアルブートする際の時計ずれ対策）

systemd が無効な環境（コンテナ、systemd 無効 WSL 等）では呼ばない。

### 2c_preference_desktop.bash

- 時計に日付と曜日を表示（gsettings）
- Caps Lock を Ctrl に変更（gsettings）
- xkb キーマップ（無変換キー + hjkl でカーソル移動）

X11/GNOME 前提。CLI/headless 環境では呼ばない。

### 2d_preference_mozc.bash

- `mozc-utils-gui` インストール
- Mozc プロパティ設定ダイアログをインタラクティブに開く

GUI（DISPLAY）が必要。

### 5_delete_preference.bash

2a-d で作成されたシンボリックリンク・設定を削除する。再設定したい場合は該当スクリプトを再実行。

### 6_copy_ssh_to_windows.bash

WSL2 側の SSH 鍵を Windows 側の `%USERPROFILE%\.ssh` にコピーする。`1c_run_wsl.bash` から自動で呼ばれるが、単体実行も可。

### software/\<name\>/install.bash

各ソフトウェアの個別インストールスクリプト。

- `uv/` — Python パッケージマネージャ（`curl https://astral.sh/uv/install.sh`）
- `gh/` — GitHub CLI（apt 公式リポジトリ経由）
- `claude-code/` — Claude Code CLI
- `codex/` — OpenAI Codex CLI（Node.js / npm が必要）
- `code/` — VS Code Desktop
- `docker/` — Docker Engine
- `tmux/`
- `brave-browser/`
- `google-chrome-stable/`
- `terminator/`
- `ulauncher/`
