#enable conda
source /anaconda3/etc/fish/conf.d/conda.fish

#Aliases (eagerly loaded - move to .config/fish/functions in future
alias ..="cd .."
alias ...="cd ../.."

#aliases for ls 
alias l="ls -lh"
alias ld="ls -l | grep '^d'"
alias lsa="ls -lsa"
alias lsd='ls -l | grep "^d"'

#aliases to jump to frequently-used directories
alias cdd="cd ~/Documents"
alias cdv="cd ~/Documents/development"
alias cdp="cd ~/Projects"
alias cdh="cd ~"
alias dl="cd ~/Downloads"

set fish_greeting "🐟"

#github-friendly prompt
function fish_prompt --description 'Write out the prompt'
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
    set __git_cb ":"(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

    case root

    if not set -q __fish_prompt_cwd
        if set -q fish_color_cwd_root
            set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
            set -g __fish_prompt_cwd (set_color $fish_color_cwd)
        end
    end

    printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    case '*'

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end
