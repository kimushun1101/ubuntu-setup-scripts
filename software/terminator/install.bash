echo -e "\033[32mTerminator will be installed.\033[m"
sudo apt update
sudo apt install -y terminator
mkdir -p ~/.config/terminator
ln -sf $(pwd)/config/terminator_config ~/.config/terminator/config