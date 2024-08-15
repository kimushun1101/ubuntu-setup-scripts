echo -e "\033[32mInstall : Terminator\033[m"
sudo apt install -y terminator
mkdir -p ~/.config/terminator
ln -sf $(pwd)/config/terminator_config ~/.config/terminator/config