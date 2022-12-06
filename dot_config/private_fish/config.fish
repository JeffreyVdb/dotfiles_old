if status is-interactive
    if type -q zoxide
        zoxide init fish | source
    end

    if type -q kubectl
        kubectl completion fish | source
    end

    if test -x /home/linuxbrew/.linuxbrew/bin/brew
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
    end

    if type -q /usr/bin/nvim
        set -gx EDITOR /usr/bin/nvim
    else if type -q /usr/bin/vim
        set -gx EDITOR /usr/bin/vim
    else if type -q /usr/bin/nano
        set -gx EDITOR /usr/bin/nano
    end

    if type -q shadowenv
        shadowenv init fish | source
    end

    if test -d "$HOME/.asdf"
        source "$HOME/.asdf/asdf.fish"
    end

    abbr --add dnfu "sudo dnf upgrade --refresh"
    abbr --add dnfi "sudo dnf install"
    abbr --add dnfs "sudo dnf search"

    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end


    # AWS CLI autocomplete
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'

    # Emulates vim's cursor shape behavior
    # Set the normal and visual mode cursors to a block
    set fish_cursor_default block
    # Set the insert mode cursor to a line
    set fish_cursor_insert line
    # Set the replace mode cursor to an underscore
    set fish_cursor_replace_one underscore
    # The following variable can be used to configure cursor shape in
    # visual mode, but due to fish_cursor_default, is redundant here
    set fish_cursor_visual block
end

function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end
