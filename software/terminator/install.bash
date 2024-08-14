sudo apt update
sudo apt install -y terminator
mkdir -p ~/.config/terminator
ln -sf $(pwd)/config/terminator_config ~/.config/terminator/config