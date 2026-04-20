[日本語](/README.md) | [English](/README_en.md)

# Ubuntu setup scripts

Setup scripts for Ubuntu (Desktop / Server / WSL2 / Container).

## Quick install (curl | bash)

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

If you want to review the script before running, open the file in [install/](/install/) in the browser and copy-paste.

## Manual install

```
sudo apt install git
git clone https://github.com/kimushun1101/ubuntu-setup-scripts.git ~/.ubuntu-setup-scripts
cd ~/.ubuntu-setup-scripts
# Pick one:
# ./1a_run_desktop.bash
# ./1b_run_server.bash
# ./1c_run_wsl.bash
# ./1d_run_container.bash
```

## Environment matrix

Preference scripts invoked per environment:

| env | entry | 2a common | 2b systemd | 2c desktop | 2d mozc | 6 ssh→win |
|---|---|:-:|:-:|:-:|:-:|:-:|
| Desktop   | 1a | ● | ● | ● | ● |   |
| Server    | 1b | ● |   |   |   |   |
| WSL2      | 1c | ● |   |   |   | ● |
| Container | 1d | ● |   |   | ● |   |

Software is called per package from each `1*_run_*.bash` via `software/<name>/install.bash`. Defaults:

| env | uv | gh | claude-code | codex | code | docker | tmux | brave-browser |
|---|:-:|:-:|:-:|:-:|:-:|:-:|:-:|:-:|
| Desktop   | ● | ● | ● | ● | ● | ● | ● | ● |
| Server    | ● | ● | ● | ● |   | ● | ● |   |
| WSL2      | ● | ● | ● | ● |   | ● | ● |   |
| Container | ● | ● | ● | ● |   | ● | ● |   |

`google-chrome-stable` / `terminator` / `ulauncher` are kept commented-out in Desktop entry (enable if needed). VS Code is not pre-installed on Server/WSL/Container; Remote-SSH / Dev Containers auto-install `~/.vscode-server`.

## Contents

### 1a_run_desktop.bash / 1b_run_server.bash / 1c_run_wsl.bash / 1d_run_container.bash

Environment-specific entry points. Runs `sudo apt update` → preference scripts → software installs.

### 2a_preference_common.bash

- Install vim
- Symlinks to `config/.vimrc` and `config/bash_aliases`
- Home directory names in English

### 2b_preference_systemd.bash

- `timedatectl set-local-rtc true` (to align clock when dual-booting with Windows)

Skip on environments without systemd (containers, systemd-less WSL).

### 2c_preference_desktop.bash

- Show date and weekday on the clock (gsettings)
- Caps Lock → Ctrl (gsettings)
- xkb keymap (Muhenkan + hjkl cursor movement)

Requires X11/GNOME. Skip on CLI/headless.

### 2d_preference_mozc.bash

- Install `mozc-utils-gui`
- Open Mozc property dialog interactively

Requires DISPLAY.

### 5_delete_preference.bash

Removes symlinks and settings created by 2a-d. Rerun the corresponding script to reconfigure.

### 6_copy_ssh_to_windows.bash

Copies WSL2 SSH key to `%USERPROFILE%\.ssh` on the Windows side. Invoked from `1c_run_wsl.bash` automatically.

### software/\<name\>/install.bash

Per-software install scripts.

- `uv/` — Python package manager (`curl https://astral.sh/uv/install.sh`)
- `gh/` — GitHub CLI (via official apt repository)
- `claude-code/` — Claude Code CLI
- `codex/` — OpenAI Codex CLI (requires Node.js / npm)
- `code/` — VS Code Desktop
- `docker/` — Docker Engine
- `tmux/`
- `brave-browser/`
- `google-chrome-stable/`
- `terminator/`
- `ulauncher/`
