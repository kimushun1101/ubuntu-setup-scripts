#!/bin/bash -eu
# Install HackGen NF font (Hack + 源柏ゴシック + Nerd Fonts) from GitHub Releases
# Reference: https://github.com/yuru7/HackGen
echo -e "\033[32mInstall : HackGen NF font\033[m"

for cmd in curl unzip fc-cache; do
  if ! command -v $cmd &> /dev/null; then
    sudo apt update
    sudo apt install -y curl unzip fontconfig
    break
  fi
done

REPO="yuru7/HackGen"
FONT_PATTERN="HackGen_NF"
FONT_DIR="${HOME}/.local/share/fonts/HackGenNF"

VERSION=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest" \
  | grep -oP '"tag_name":\s*"v\K[^"]+')
echo "Target version: ${VERSION}"

ZIP_NAME="${FONT_PATTERN}_v${VERSION}.zip"
DOWNLOAD_URL="https://github.com/${REPO}/releases/download/v${VERSION}/${ZIP_NAME}"
TEMP_DIR=$(mktemp -d)

curl -fsSL -o "${TEMP_DIR}/${ZIP_NAME}" "${DOWNLOAD_URL}"
unzip -qo "${TEMP_DIR}/${ZIP_NAME}" -d "${TEMP_DIR}"

mkdir -p "${FONT_DIR}"
find "${TEMP_DIR}" -name "*.ttf" -exec cp {} "${FONT_DIR}/" \;
fc-cache -f "${FONT_DIR}"
rm -rf "${TEMP_DIR}"

echo "HackGen NF installed to ${FONT_DIR}"
