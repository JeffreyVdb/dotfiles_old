#!/bin/bash
set -euo pipefail

is_fedora() {
    [[ "fedora" == $(grep -P '^ID' /etc/os-release | awk -F= '{print $2}') ]]
}

install_fish_shell() {
    sudo dnf install -y fish
    FISHER_SCRIPT=$(mktemp)
    trap 'rm -f $FISHER_SCRIPT' RETURN

    curl -L -o "$FISHER_SCRIPT" https://raw.githubusercontent.com/jorgebucaran/fisher/4.3.1/functions/fisher.fish

    local CSUM
    CSUM=$(sha256sum "$FISHER_SCRIPT" | awk '{print $1}')
    test "34c6f4cb4847d27bd7f081ebeafc10585eea31d3a1b1f7bf630108fc658c9529" == "$CSUM"

    fish "$FISHER_SCRIPT"
    fish -c "fisher install jorgebucaran/hydro"
}

if is_fedora; then
    sudo dnf install -y cargo rust

    install_fish_shell

    # Install neovim
    sudo dnf install -y neovim
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 20000
    
    # Rust packages
    cargo install git-delta
    cargo install fd-find
fi
