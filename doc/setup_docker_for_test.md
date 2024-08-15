# Docker for test

このスクリプトをテストするために Dockerfile を用意した．  
途中途中で Yes / No を聞いてくるので，GitHub Actions は難しそうだった． 

ビルドして実行
```
docker build ./ -t dotfiles-test
docker run -it --rm dotfiles-test /bin/bash
```
コンテナ内
```
git clone https://github.com/kimushun1101/ubuntu-setup-scripts.git ~/.ubuntu-setup-scripts
~/.ubuntu-setup-scripts/1_run_all_scripts.bash
```
後片付け
```
docker rmi dotfiles-test
docker image prune
```