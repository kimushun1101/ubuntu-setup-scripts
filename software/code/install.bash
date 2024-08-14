# VS Code
echo -e "\033[32mVS Code will be installed.\033[m"
curl -L http://go.microsoft.com/fwlink/?LinkID=760868 -o code.deb
sudo apt install ./code.deb
rm -f code.deb