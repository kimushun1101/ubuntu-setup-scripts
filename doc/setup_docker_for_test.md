# Docker for test

各 entry スクリプト (`1a_run_desktop.bash` / `1b_run_server.bash` / `1d_run_container.bash`) を Docker 内で動作確認するためのガイド。`1c_run_wsl.bash` は Windows 側との連携 (`6_copy_ssh_to_windows.bash`) があり Docker でテスト不可。

## ビルド

`Dockerfile` は multi-stage 構成。

```
docker build --target server  -t ubuntu-setup-test:server  .
docker build --target desktop -t ubuntu-setup-test:desktop .
```

オプション (default 値):

| ARG | default | 例 |
|---|---|---|
| `UBUNTU_VERSION` | `24.04` | `--build-arg UBUNTU_VERSION=22.04` |
| `TZ` | `Asia/Tokyo` | `--build-arg TZ=Europe/London` |

例:

```
docker build --target server --build-arg UBUNTU_VERSION=22.04 -t ubuntu-setup-test:server .
```

## Server (1b) / Container (1d)

CLI のみで動作するので server image を使う。リポジトリを bind mount してそのまま entry を呼ぶ。

```
docker run --rm -it -v "$PWD:/work" -w /work ubuntu-setup-test:server ./1b_run_server.bash
docker run --rm -it -v "$PWD:/work" -w /work ubuntu-setup-test:server ./1d_run_container.bash
```

非対話で全 default 採用:

```
docker run --rm -e ASSUME_YES=1 -v "$PWD:/work" -w /work ubuntu-setup-test:server ./1b_run_server.bash
```

注: 個別 install 失敗 (例: container 内での `docker` インストール) はベストエフォートで続行され、最後に赤字でレポートされる。

## Desktop (1a)

GUI 系を含むため desktop image + ホストの X サーバ共有で実行する。

```
xhost +local:docker
docker run --rm -it \
  -e DISPLAY="$DISPLAY" \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v "$PWD:/work" -w /work \
  ubuntu-setup-test:desktop ./1a_run_desktop.bash
xhost -local:docker
```

注意:

- `2c_preference_desktop.bash` の `gsettings` は dbus session が無いと値が永続化されない。container 内で `eval $(dbus-launch --sh-syntax)` を先に実行しておくとマシ。それでも失敗したら entry のベストエフォート挙動で続行される
- `2d_preference_mozc.bash` は `mozc_tool` ダイアログが開く。GUI 操作後に閉じないと先に進まない (ダイアログ自体が出ない場合は X 共有を再確認)

## 個別 ask 動作だけ確認したい場合

`software/_prompt_lib.bash` の挙動 (alternative 分岐 / 確認画面) を試したいだけなら、preference 群が無くても良いので server image で十分:

```
docker run --rm -it -v "$PWD:/work" -w /work ubuntu-setup-test:server bash -c '
source ./software/_prompt_lib.bash
ask_pkg brave-browser y "推奨ブラウザ"
if [ "${_STEP_CHOICE[brave-browser]}" = "n" ]; then
  ask_pkg google-chrome-stable y "代替ブラウザ"
fi
ask_pkg ghostty y "推奨ターミナル"
if [ "${_STEP_CHOICE[ghostty]}" = "n" ]; then
  ask_pkg terminator y "代替ターミナル"
fi
confirm_or_abort
'
```

## 後片付け

```
docker rmi ubuntu-setup-test:server ubuntu-setup-test:desktop
docker image prune
```
