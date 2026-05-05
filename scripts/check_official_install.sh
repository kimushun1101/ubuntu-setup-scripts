#!/bin/bash
# 公式 installer / pinned upstream の drift を定期検知するスクリプト
#
# 対象は 2 種類:
#   (1) curl|sh 系の installer 本文 — sha256 を snapshot と比較
#   (2) 自前で version pin している upstream — pinned vs latest を比較
#
# Usage:
#   scripts/check_official_install.sh           # check (drift があれば exit 1)
#   scripts/check_official_install.sh --update  # 現在値で snapshot を上書き

set -e

cd "$(dirname "$0")/.."

SNAPSHOT_DIR="scripts/snapshots"
mkdir -p "$SNAPSHOT_DIR"

# (1) sha256 比較対象
#     "<name>|<url>"
SHA256_TARGETS=(
  "uv|https://astral.sh/uv/install.sh"
  "claude-code|https://claude.ai/install.sh"
  "brave-browser|https://dl.brave.com/install.sh"
  "docker|https://get.docker.com"
  "ghostty|https://raw.githubusercontent.com/mkasberg/ghostty-ubuntu/HEAD/install.sh"
)

mode="check"
if [ "${1:-}" = "--update" ]; then
  mode="update"
fi

drifts=()

# (1) sha256 比較
for target in "${SHA256_TARGETS[@]}"; do
  name="${target%%|*}"
  url="${target#*|}"
  if ! body=$(curl -fsSL --max-time 30 "$url" 2>/dev/null); then
    echo "[ERROR]  $name: fetch failed ($url)"
    drifts+=("$name (fetch error)")
    continue
  fi
  current_hash=$(printf '%s' "$body" | sha256sum | awk '{print $1}')
  snap_file="$SNAPSHOT_DIR/$name.sha256"

  if [ "$mode" = "update" ]; then
    printf '%s  %s\n' "$current_hash" "$url" > "$snap_file"
    echo "[update] $name: $current_hash"
    continue
  fi

  if [ ! -f "$snap_file" ]; then
    echo "[init]   $name: snapshot 未作成 — --update で初期化してください (current=$current_hash)"
    drifts+=("$name (no snapshot)")
    continue
  fi
  stored_hash=$(awk '{print $1; exit}' "$snap_file")
  if [ "$current_hash" = "$stored_hash" ]; then
    echo "[ok]     $name"
  else
    echo "[DRIFT]  $name: stored=$stored_hash current=$current_hash"
    drifts+=("$name")
  fi
done

# (2) pinned version 比較
# nvm: software/nodejs/install.bash の NVM_VERSION="vX.Y.Z" と
#      https://api.github.com/repos/nvm-sh/nvm/releases/latest の tag_name を比較
nvm_pinned=$(grep -oE 'NVM_VERSION="v[0-9.]+"' software/nodejs/install.bash | head -1 | sed 's/NVM_VERSION="\(.*\)"/\1/')
nvm_latest=$(curl -fsSL --max-time 30 https://api.github.com/repos/nvm-sh/nvm/releases/latest \
  | grep -oE '"tag_name":[[:space:]]*"v[0-9.]+"' | head -1 \
  | sed 's/.*"\(v[0-9.]\+\)".*/\1/')

if [ "$mode" = "update" ]; then
  # pinned 比較は snapshot を持たないので update では何もしない
  :
elif [ -z "$nvm_pinned" ] || [ -z "$nvm_latest" ]; then
  echo "[ERROR]  nvm: 取得失敗 (pinned=$nvm_pinned latest=$nvm_latest)"
  drifts+=("nvm (fetch error)")
elif [ "$nvm_pinned" = "$nvm_latest" ]; then
  echo "[ok]     nvm: pinned=$nvm_pinned"
else
  echo "[DRIFT]  nvm: pinned=$nvm_pinned latest=$nvm_latest"
  drifts+=("nvm")
fi

if [ "$mode" = "update" ]; then
  echo
  echo "snapshot 更新完了 (drift 比較は --update では行いません)"
  exit 0
fi

if [ "${#drifts[@]}" -gt 0 ]; then
  echo
  echo "Drift detected: ${drifts[*]}"
  exit 1
fi
echo
echo "All targets in sync."
