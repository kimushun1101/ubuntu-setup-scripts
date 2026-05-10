#!/bin/bash -eu
# Install BIZ UD fonts (Gothic + Mincho, 等幅 + プロポーショナル) from GitHub Releases
# References:
#   https://github.com/googlefonts/morisawa-biz-ud-gothic
#   https://github.com/googlefonts/morisawa-biz-ud-mincho
echo -e "\033[32mInstall : BIZ UD fonts (Gothic + Mincho)\033[m"

for cmd in curl unzip fc-cache; do
  if ! command -v $cmd &> /dev/null; then
    sudo apt install -y curl unzip fontconfig
    break
  fi
done

install_biz_ud() {
  local repo="$1"
  local family="$2"  # 表示用 (例: Gothic / Mincho)
  local font_dir="${HOME}/.local/share/fonts/BIZUD${family}"

  local tag
  tag=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
    | grep -oP '"tag_name":\s*"\K[^"]+')
  echo "  ${family}: target tag ${tag}"

  local zip_name="morisawa-biz-ud-${family,,}-fonts.zip"
  local download_url="https://github.com/${repo}/releases/download/${tag}/${zip_name}"
  local temp_dir
  temp_dir=$(mktemp -d)

  curl -fsSL -o "${temp_dir}/${zip_name}" "${download_url}"
  unzip -qo "${temp_dir}/${zip_name}" -d "${temp_dir}"

  mkdir -p "${font_dir}"
  find "${temp_dir}" -name "*.ttf" -exec cp {} "${font_dir}/" \;
  rm -rf "${temp_dir}"

  echo "  ${family}: installed to ${font_dir}"
}

install_biz_ud "googlefonts/morisawa-biz-ud-gothic" "Gothic"
install_biz_ud "googlefonts/morisawa-biz-ud-mincho" "Mincho"

fc-cache -f "${HOME}/.local/share/fonts"

echo "BIZ UD fonts installed (BIZUDGothic, BIZUDPGothic, BIZUDMincho, BIZUDPMincho)"
