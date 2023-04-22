#!/bin/bash
cd `dirname $0`

# home directory in English
LANG=C xdg-user-dirs-gtk-update

# config files
mkdir -p ~/.vimbackup
ln -sf $(pwd)/config/vimrc ~/.vimrc
ln -sf $(pwd)/config/bash_aliases ~/.bash_aliases
ln -sf $(pwd)/config/xkb ~/.xkb
mkdir -p ~/.config/terminator
ln -sf $(pwd)/config/terminator_config ~/.config/terminator/config

# time setting
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true
# gsettings set org.gnome.desktop.interface clock-show-seconds true
timedatectl set-local-rtc true

# keyboard settings
gsettings set org.gnome.desktop.input-sources xkb-options "['ctrl:nocaps']"
bashrc_path="$HOME/.bashrc"
xkb_command='xkbcomp -I$HOME/.xkb ~/.xkb/keymap/mykbd $DISPLAY 2> /dev/null'
if ! grep -q "$xkb_command" "$bashrc_path"; then
  echo "$xkb_command" >> "$bashrc_path"
fi
source $bashrc_path

# mozc settings
while true; do
  read -p "Do you import Mozc Property? (y:Yes/n:No): " yn
  case "$yn" in
    [yY]*)
      echo "キー設定の選択 → 編集... → 編集 → インポート... → keymap_for_mozc.txt(一時的にホームディレクトリにコピーされています)"
      ln -sf $(pwd)/config/keymap_for_mozc.txt ~/keymap_for_mozc.txt
      /usr/lib/mozc/mozc_tool --mode=config_dialog
      rm -f ~/keymap_for_mozc.txt
      break;;
    [nN]*) echo "Mozc setting was skipped."; break ;;
    *);;
  esac
done

echo "Preference setting is complete!"
