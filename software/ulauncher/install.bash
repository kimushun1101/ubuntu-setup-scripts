sudo add-apt-repository universe -y
sudo add-apt-repository ppa:agornostal/ulauncher -y
sudo apt update
sudo apt install ulauncher xdotool
ln -sf $(pwd)/ulauncher/config ~/.config/ulauncher
