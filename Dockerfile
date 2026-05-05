# Multi-stage Dockerfile — 各 entry スクリプトを Docker 内でテストするための image
#
# ビルド:
#   docker build --target server  -t ubuntu-setup-test:server  .
#   docker build --target desktop -t ubuntu-setup-test:desktop .
#
# オプション:
#   --build-arg UBUNTU_VERSION=22.04   (default 24.04)
#   --build-arg TZ=Europe/London       (default Asia/Tokyo)
#
# テスト手順は doc/test_in_docker.md を参照

ARG UBUNTU_VERSION=24.04

# ===== base =====
# 全 entry に共通の依存と sudo-user 作成、TZ・locale 固定
FROM ubuntu:${UBUNTU_VERSION} AS base

ARG TZ=Asia/Tokyo
ENV TZ=${TZ} \
    DEBIAN_FRONTEND=noninteractive \
    LANG=ja_JP.UTF-8 \
    LANGUAGE=ja_JP:ja \
    LC_ALL=ja_JP.UTF-8

RUN apt-get update && apt-get install -y --no-install-recommends \
        sudo git tzdata ca-certificates curl wget \
        xdg-user-dirs locales \
    && ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && locale-gen ja_JP.UTF-8 \
    && update-locale LANG=ja_JP.UTF-8 \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/* \
    && useradd -m -s /bin/bash sudo-user \
    && usermod -aG sudo sudo-user \
    && echo "sudo-user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER sudo-user
WORKDIR /home/sudo-user
CMD ["/bin/bash"]

# ===== server =====
# 1b_run_server.bash / 1d_run_container.bash テスト用 (CLI のみ)
FROM base AS server

# ===== desktop =====
# 1a_run_desktop.bash テスト用
# 2c_preference_desktop.bash (gsettings / xkbcomp) と 2d_preference_mozc.bash の依存を事前投入
# X サーバはホスト DISPLAY 共有を想定 (doc/test_in_docker.md 参照)
FROM base AS desktop

USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
        dconf-cli gsettings-desktop-schemas \
        xkb-data x11-xkb-utils \
        dbus-x11 \
        mozc-utils-gui \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
USER sudo-user
