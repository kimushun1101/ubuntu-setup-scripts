# setup-ubuntu20

Setup scripts for Ubuntu 20.04

## Contents

### Manually setup

Import keymap.txt from Mozc settings.  
The input type (Japanese or English) can be switched by Henkan or Muhenkan key.  
If you miss the Mozc setting and run "1_install_settings.sh", the file "keymap.txt" exists in ~/.setup/keymap.txt.
If ".setup" directory is not appeared, press Ctrl-h.

### 0_apt_settings.sh

- apt server is setup.
- update, upgrade, and autoremove.

### 1_install_settings.sh

- Folder names is in English.
- Install vim, terminator, docker, xcape and xsel.
- Navigate to GUI installer for Google Chrome, VS Code, and Slack.
- Paste symbolic links for vim, bash and keyboard setting.
- Make a vimbackup directory.
- Caps Lock Key becomes Ctrl key.
- Shows date and seconds on the clock.

### 2_set_git_config.sh

To edit this file for git global setting.
Replace user name and the email address infomation for you.
Then, run it.

### 3_install_ros.sh

Install ros2 environment.
(As of August 17, 2020)
