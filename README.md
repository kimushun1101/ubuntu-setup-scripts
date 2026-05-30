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

各 preference / software の実行可否は y/n で対話的に選択できる。質問はまとめて聞かれ、確認画面の後にまとめて実行される。完全自動で進めたい場合は `ASSUME_YES=1` を付ける（全項目で各環境のデフォルトを採用）:

```
ASSUME_YES=1 ./1a_run_desktop.bash
```

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

各エントリーポイントが呼ぶ preference / software の対応（Y = デフォルト Y で対話質問、N = デフォルト N で対話質問、空欄 = 質問されない）。

Preference:

| 環境 | entry | 2a-common | 2b-systemd | 2c-desktop | 2d-mozc | 6 ssh→win |
|---|---|:-:|:-:|:-:|:-:|:-:|
| Desktop   | 1a | Y | Y | Y | Y |   |
| Server    | 1b | Y |   |   |   |   |
| WSL2      | 1c | Y |   |   |   | ● |
| Container | 1d | Y |   |   | Y |   |

`6 ssh→win` の `●` は WSL のみ常時実行（対話なし）。

Software は `software/<name>/install.bash` を各 `1*_run_*.bash` から個別に呼ぶ。各環境で対話質問される候補:

| 環境 | uv | gh | claude-code | nodejs | codex | code | docker | tmux | brave-browser | ghostty | hackgen | google-chrome | terminator | muhenkan-switch |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Desktop   | Y | Y | Y | Y | Y | Y | Y | Y | Y | Y | Y | Y\* | Y\* | Y |
| Server    | Y | Y | Y | Y | Y |   | Y | Y |   |   |   |     |     |   |
| WSL2      | Y | Y | Y | Y | Y |   | Y | Y |   |   |   |     |     |   |
| Container | Y | Y | Y | Y | Y |   | Y | Y |   |   | Y |     |     |   |

\* `google-chrome-stable` は `brave-browser` を `n` と答えたときのみ質問される（代替ブラウザとして default Y）。同様に `terminator` は `ghostty` を `n` と答えたときのみ質問される（代替ターミナル）。

`nodejs` は `~/.nvm` 配下に Node.js LTS を入れる (`/usr/local` を汚さない)。`codex` (npm install -g) の依存として共通投入。

VS Code の Server/WSL/Container への事前インストールは不要（Remote-SSH / Dev Containers で `~/.vscode-server` が自動配置されるため）。

### 失敗時の挙動

個別の preference / software スクリプトがエラーで終了しても、残りの項目は続行される（ベストエフォート）。最後に失敗した項目名が赤字でレポートされ、entry スクリプトは exit 1 で終了する。

## Docker でテスト

各 entry を Docker 内で動作確認できる（multi-stage Dockerfile, `--target server` / `--target desktop`）。手順は [doc/setup_docker_for_test.md](doc/setup_docker_for_test.md) を参照。

## 公式 installer の drift 検知

各 `software/<name>/install.bash` が依存している upstream installer / pinned version に変化があるかを定期的に検査する仕組みを `.github/workflows/check-official-install.yml` で運用している（毎月 1 日に cron 実行 + 手動 `workflow_dispatch` 可）。

検知対象 (PoC): `uv` / `claude-code` / `brave-browser` / `docker` / `ghostty` の installer 本文 sha256、および `nodejs` の nvm pinned version。詳細は [scripts/check_official_install.sh](scripts/check_official_install.sh) を参照。

ローカル実行:

```
./scripts/check_official_install.sh           # check (drift があれば exit 1)
./scripts/check_official_install.sh --update  # 現在値で snapshot を上書き
```

drift が検知されると CI が同タイトルの open issue を再利用 (またはなければ新規起票) してコメントを残す。

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
- `nodejs/` — Node.js LTS（nvm 経由で `~/.nvm` に配置、`/usr/local` 非汚染）
- `codex/` — OpenAI Codex CLI（`nodejs/` の npm を使う、`npm install -g`）
- `code/` — VS Code Desktop
- `docker/` — Docker Engine
- `tmux/`
- `brave-browser/`
- `google-chrome-stable/`
- `terminator/`
- `muhenkan-switch/` — 無変換キー同時押しショートカットツール（公式ワンライナー `scripts/install/get.sh` 経由、X11 検証済み）。Desktop の `1a` で質問される
- `ulauncher/` — アプリランチャー（現在どの `1*_run_*.bash` からも呼ばれない。`muhenkan-switch` への切替に伴い選択肢から外したが、手動実行用に残置）
- `ghostty/` — モダンなターミナルエミュレータ（mkasberg/ghostty-ubuntu の install.sh 経由 + `update-alternatives` でデフォルト切替）
- `hackgen/` — プログラミング向け日本語フォント HackGen NF（GitHub Releases から最新版）
