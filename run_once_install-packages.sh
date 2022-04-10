#!/bin/bash
set -euo pipefail

is_fedora() {
    [[ "fedora" == $(grep -P '^ID' /etc/os-release | awk -F= '{print $2}') ]]
}

if is_fedora; then
    sudo dnf install -y cargo rust

    # Install neovim
    sudo dnf install -y neovim
    sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 20000
    
    # Rust packages
    cargo install git-delta
    cargo install fd-find
fi
