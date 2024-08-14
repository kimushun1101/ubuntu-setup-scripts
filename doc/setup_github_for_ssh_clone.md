# SSH git clone

このリポジトリを SSH でクローンするために、4_set_git_config の処理を先に行う。  
自分用のため、他の方が使う場合には名前やメールアドレスは変更してください。

```
sudo apt update
sudo apt install git xsel -y

git config --global user.name "Shunsuke Kimura"
git config --global user.email "kimushun1101@gmail.com"
git config --global core.editor vim.tiny

ssh-keygen -t ed25519 -C "kimushun1101@gmail.com" -f $HOME/.ssh/id_ed25519
ssh-add ~/.ssh/id_ed25519
cat ~/.ssh/id_ed25519.pub | xsel --clipboard --input
echo "Copy id_ed25519.pub to your clipboard."
xdg-open https://github.com/settings/ssh > /dev/null 2>&1
read -p "Upload public key, then HIT ENTER:" continue
ssh -T git@github.com

git clone git@github.com:kimushun1101/ubuntu-setup-scripts.git ~/.ubuntu-setup-scripts
```
