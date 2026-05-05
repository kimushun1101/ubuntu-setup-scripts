# shellcheck shell=bash
# セットアップ項目の対話選択ヘルパ
#
# 使い方:
#   source ./software/_prompt_lib.bash
#   ask_step 2a-common ./2a_preference_common.bash y "共通設定"
#   ask_pkg  uv y "Python パッケージマネージャ"   # = ask_step uv ./software/uv/install.bash y ...
#   confirm_or_abort
#   run_all
#
# 環境変数:
#   ASSUME_YES=1  すべての質問で default を採用 (curl|bash / CI 用)

_STEP_ORDER=()
declare -A _STEP_CHOICE
declare -A _STEP_SCRIPT
declare -A _STEP_DESC
_STEP_FAILED=()

# ask_step <name> <script> <default y|n> [説明]
ask_step() {
  local name="$1"
  local script="$2"
  local default="${3:-y}"
  local desc="${4:-}"
  local prompt_hint
  if [ "$default" = "y" ]; then prompt_hint="[Y/n]"; else prompt_hint="[y/N]"; fi

  local label="$name"
  [ -n "$desc" ] && label="$name ($desc)"

  local ans=""
  if [ "${ASSUME_YES:-0}" = "1" ]; then
    ans="$default"
    echo "  $label : $default (ASSUME_YES)"
  elif [ -r /dev/tty ]; then
    read -r -p "Run $label? $prompt_hint " ans </dev/tty || ans=""
  else
    ans="$default"
    echo "  [warn] tty が無いため $label は default ($default) を採用" >&2
  fi

  ans="${ans:-$default}"
  case "$ans" in
    y|Y|yes|YES) _STEP_CHOICE[$name]="y" ;;
    *)           _STEP_CHOICE[$name]="n" ;;
  esac
  _STEP_ORDER+=("$name")
  _STEP_SCRIPT[$name]="$script"
  _STEP_DESC[$name]="$desc"
}

# ask_pkg <name> <default y|n> [説明]
#   ask_step の薄いラッパー (script = ./software/<name>/install.bash)
ask_pkg() {
  ask_step "$1" "./software/$1/install.bash" "${2:-y}" "${3:-}"
}

# confirm_or_abort
#   サマリ表示 + 最終確認 (ASSUME_YES に関わらず tty があれば必ず聞く)
confirm_or_abort() {
  echo
  echo "=== 実行対象 ==="
  local n
  for n in "${_STEP_ORDER[@]}"; do
    if [ "${_STEP_CHOICE[$n]}" = "y" ]; then
      printf "  \033[32m[Y]\033[m %s\n" "$n"
    else
      printf "  [ ] %s\n" "$n"
    fi
  done
  echo

  local ans=""
  if [ -r /dev/tty ]; then
    read -r -p "上記で実行を開始しますか? [Y/n] " ans </dev/tty || ans=""
  fi
  ans="${ans:-y}"
  case "$ans" in
    y|Y|yes|YES) ;;
    *) echo "Aborted."; exit 0 ;;
  esac
}

# run_all
#   y のものを順に実行。個別失敗はベストエフォートで続行し、最後に失敗一覧を表示
run_all() {
  local n script
  for n in "${_STEP_ORDER[@]}"; do
    [ "${_STEP_CHOICE[$n]}" = "y" ] || continue
    script="${_STEP_SCRIPT[$n]}"
    echo
    echo -e "\033[36m=== $n ===\033[m"
    if [ ! -x "$script" ]; then
      echo -e "\033[31m[error] $script が見つかりません\033[m" >&2
      _STEP_FAILED+=("$n")
      continue
    fi
    if ! "$script"; then
      echo -e "\033[31m[error] $n の実行に失敗しました\033[m" >&2
      _STEP_FAILED+=("$n")
    fi
  done

  if [ "${#_STEP_FAILED[@]}" -gt 0 ]; then
    echo
    echo -e "\033[31m=== 失敗した項目 ===\033[m"
    local f
    for f in "${_STEP_FAILED[@]}"; do
      echo -e "  \033[31m- $f\033[m"
    done
    return 1
  fi
  return 0
}
