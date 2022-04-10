if status is-interactive
    if type -q /usr/bin/nvim
        set -gx EDITOR /usr/bin/nvim
    else if type -q /usr/bin/vim
        set -gx EDITOR /usr/bin/vim
    else if type -q /usr/bin/nano
        set -gx EDITOR /usr/bin/nano
    end

    abbr --add dnfu "sudo dnf upgrade --refresh"
end
