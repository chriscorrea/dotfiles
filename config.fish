#enable conda
source /anaconda3/etc/fish/conf.d/conda.fish

#Aliases (eagerly loaded - move to .config/fish/functions in future
alias ..="cd .."
alias ...="cd ../.."


function l --description 'Custom ls-like output, simplified and colorized'

    stat  -l -F -t '%F' {*,.??*} | awk 'BEGIN{cmd = "date +%Y-%m-%d" | getline today}; {if (index($7,"\/")>0) print "\033[1;30m"$1,$6,"\033[0;34m"$7"\033[0m"; else if (index($7,"*")>0 && $6==today) print "\033[1;30m"$1,"\033[0;93m"$6,$7"\033[0m"; else if (index($7,"*")>0) print "\033[1;30m"$1,$6,"\033[0;93m"$7"\033[0m" ; else if ($6==today) print "\033[1;30m"$1,"\033[0;97m"$6,$7; else print "\033[1;30m"$1,$6,"\033[0;37m"$7;}'

end


#alias ls="ls -ahGp"
alias ld="ls -lGp | grep '^d'"
alias lsa="ls -lsahGp"

alias recent="find . -mtime +8 -prune -print"
alias old="find . -mtime -364 -prune -print"

alias doc="cd ~/Documents"
alias dev="cd ~/Documents/development"
alias cdh="cd ~"
alias dl="cd ~/Downloads"


alias rmall = "rm -fdr"

set fish_greeting "🐟"

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

    printf '%s%s%s%s# ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    case '*'

    if not set -q __fish_prompt_cwd
        set -g __fish_prompt_cwd (set_color $fish_color_cwd)
    end

    printf '%s%s%s%s$ ' "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end
