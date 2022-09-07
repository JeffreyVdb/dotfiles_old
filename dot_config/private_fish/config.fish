if status is-interactive
    if type -q zoxide
        zoxide init fish | source
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

    abbr --add dnfu "sudo dnf upgrade --refresh"

    function mark_prompt_start --on-event fish_prompt
        echo -en "\e]133;A\e\\"
    end


    # AWS CLI autocomplete
    complete --command aws --no-files --arguments '(begin; set --local --export COMP_SHELL fish; set --local --export COMP_LINE (commandline); aws_completer | sed \'s/ $//\'; end)'
end
