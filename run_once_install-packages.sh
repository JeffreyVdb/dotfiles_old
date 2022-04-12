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

    fish -c "source $FISHER_SCRIPT; 
             fisher install jorgebucaran/hydro;
             fisher install PatrickF1/fzf.fish"
}

install_neovim() {
    sudo dnf install -y neovim
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 20000

    if [[ ! -f ~/.local/venv/nvim/bin/python3 ]]; then
        mkdir -p ~/.local/venv
        pushd ~/.local/venv &>/dev/null
        python3 -m venv nvim
        ~/.local/venv/nvim/bin/python3 -m pip install --upgrade pip
        ~/.local/venv/nvim/bin/python3 -m pip install pynvim black
        popd &>/dev/null
    fi
}

if is_fedora; then
    # Common packages
    sudo dnf install -y fzf nodejs

    # Development tooling
    sudo dnf install -y libstdc++-devel clang ShellCheck
    
    # Rust packages
    sudo dnf install -y cargo rust

    cargo install --quiet git-delta
    cargo install --quiet fd-find

    install_fish_shell
    install_neovim
fi
