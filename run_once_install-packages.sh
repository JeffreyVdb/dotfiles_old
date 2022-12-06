#!/bin/bash
set -euo pipefail

is_fedora() {
    [[ "(fedora|nobara)" =~ $(grep -P '^ID' /etc/os-release | awk -F= '{print $2}') ]]
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
        python3 -m venv ~/.local/venv/nvim
        ~/.local/venv/nvim/bin/python3 -m pip install --upgrade pip
        ~/.local/venv/nvim/bin/python3 -m pip install pynvim black
    fi
}

install_vscode() {
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

    sudo dnf install --refresh -y code
}

if is_fedora; then
    # Common packages
    sudo dnf install -y fzf nodejs

    # Development tooling
    sudo dnf install -y libstdc++-devel clang ShellCheck ripgrep
    
    # Rust packages
    sudo dnf install -y cargo rust

    cargo install --quiet git-delta
    cargo install --quiet fd-find
    cargo install --quiet cargo-update

    install_fish_shell
    install_neovim
    install_vscode
else
    echo "Unsupported distro for package installation"
fi
