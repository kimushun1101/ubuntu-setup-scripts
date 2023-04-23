[日本語](/README.md) | [English](/README_en.md)

# Ubuntu-Desktop setup scripts

Ubuntu-Desktop に対するセットアップスクリプト

## Contents

### 1_run_all_scripts.bash

5_delete_preference.bash 以外のすべてのスクリプトを実行する。

### 2_set_preference.bash

以下の設定を行う。
- ホームディレクトリのディレクトリ名を英語に変更
- vimbackup ディレクトリを作成
- config ディレクトリにあるファイルのシンボリックリンクを各所に作成
- 時計に日付と曜日を表示
- Windows とデュアルブートしたときに時計がずれないように設定
- Caps Lock キーをCtrl キーに変更
- xkb を使用して無変換キー+hjkl などでカーソル移動ができるように設定
- Mozc のキー設定を変更して、変換キーや無変換キーで日本語入力切り替えができるように設定

### 3_install_software.bash

GNOME TerminatorとGoogle Chrome、VS Code、Docker をインストールする。
不要なソフトはご自身でコメントアウトしてください。

### 4_set_github_config.bash

Git とGitHub を使うための準備をする。
- Git をインストール
- Git のglobal config を設定
- ed25519 でSSH キーを生成
- GitHub のSSH setting のページを開き、SSH キーの登録を促す
- GitHub への接続を確認

### 5_delete_preference.bash

2_set_preference.bash によって作られたファイルを削除する。
再設定したい場合には2_set_preference.bash を再実行してください。
