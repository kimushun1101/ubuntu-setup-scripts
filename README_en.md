[日本語](/README.md) | [English](/README_en.md)

# Ubuntu-Desktop setup scripts

Setup scripts for Ubuntu-Desktop.

## Contents

### 1_run_all_scripts.bash

This script runs all of the following scripts except for 5_delete_preference.bash.

### 2_set_preference.bash

This script set the following preferences.
- Folder names is in English.
- Make a vimbackup directory.
- Make symbolic links from files in config directory.
- Shows date and weekday on the clock.
- Set the clock when dual booting with Windows.
- Caps Lock Key becomes Ctrl key.
- xkb enables hjkl cursor movement with Muhenkan-key as a hotkey.
- Change keymap in Mozc that switch the input type by Henkan or Muhenkan key.

### 3_install_software.bash

This script installs terminator, Google Chrome, VS Code, and Docker.

### 4_set_github_config.bash

This script prepares you to use Git and GitHub.
- Install Git.
- set Git global config.
- Generate SSH key with ed25519.
- Navigate to GitHub SSH setting page for key registration.
- Confirm connection to GitHub.

### 5_delete_preference.bash

This script delete the file made by 2_set_preference.bash
