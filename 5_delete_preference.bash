#!/bin/bash
read -p "Do you delete files made by 2_set_preference.bash? (y:Yes/n:No): " yn
case "$yn" in [yY]*) ;; *) echo "Abort." ; exit ;; esac

gsettings reset org.gnome.desktop.input-sources xkb-options
sed -i "/xkbcomp/d" "$HOME/.bashrc"
sed -i "/xkbcomp/d" "$HOME/.profile"
rm -rf ~/.vimbackup
rm -rf ~/.vimrc
rm -rf ~/.bash_aliases
rm -rf ~/.config/terminator

echo "Config was deleted!"