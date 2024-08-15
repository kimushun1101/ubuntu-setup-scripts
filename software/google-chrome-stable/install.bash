echo -e "\033[32mInstall : Google Chrome\033[m"
curl -L https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb -o chrome.deb
sudo apt install ./chrome.deb
rm -f chrome.deb