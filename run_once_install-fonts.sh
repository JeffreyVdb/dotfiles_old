#!/bin/bash
set -euo pipefail

LOCAL_FONT_PATH="$HOME/.local/share/fonts"

install_ubuntu_fonts() {
    local TEMP_DOWN_DIR
    TEMP_DOWN_DIR=$(mktemp -d -t ubuntu-fonts-tmp-XXXXXX)
    trap 'rm -rf $TEMP_DOWN_DIR' RETURN

    # TODO: see if the link can refer to the latest version at any time
    curl -L -o "$TEMP_DOWN_DIR/ubuntu-fonts.zip" https://assets.ubuntu.com/v1/0cef8205-ubuntu-font-family-0.83.zip
    pushd "$TEMP_DOWN_DIR" &>/dev/null

    unzip ubuntu-fonts.zip
    mkdir -p "$LOCAL_FONT_PATH/ubuntu"
    find . -type f -name "Ubuntu*.ttf" -exec mv {} "$LOCAL_FONT_PATH/ubuntu" \;
    (cd "$LOCAL_FONT_PATH/ubuntu" && mkfontdir && mkfontscale && fc-cache -fv)
}

install_jetbrains_mono_fonts() {
    sudo dnf install -y jetbrains-mono-fonts-all
}

mkdir -p "$LOCAL_FONT_PATH"
install_ubuntu_fonts
install_jetbrains_mono_fonts
