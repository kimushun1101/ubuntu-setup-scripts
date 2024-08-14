# Docker
if ! command -v curl &> /dev/null; then
sudo apt update
sudo apt install -y curl
fi
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
sudo usermod -aG docker $USER
rm -f get-docker.sh
