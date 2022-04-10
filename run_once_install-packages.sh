#!/bin/bash
set -euo pipefail

is_fedora() {
    [[ "fedora" == $(grep -P '^ID' /etc/os-release | awk -F= '{print $2}') ]]
}

if is_fedora; then
    sudo dnf install -y cargo rust
    
    # Rust packages
    cargo install git-delta
    cargo install fd-find
fi
