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

set fish_greeting "🐟 $USER 🐟"

# Fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showuntrackedfiles 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow
set __fish_git_prompt_color_upstream_ahead green
set __fish_git_prompt_color_upstream_behind red

# Status Chars
set -g __fish_git_prompt_char_upstream_ahead "↑"
set -g __fish_git_prompt_char_upstream_behind "↓"
set -g __fish_git_prompt_char_upstream_prefix ""

set -g __fish_git_prompt_char_stagedstate "●"
set -g __fish_git_prompt_char_dirtystate "✚"
set -g __fish_git_prompt_char_untrackedfiles "…"
set -g __fish_git_prompt_char_conflictedstate "✖"
set -g __fish_git_prompt_char_cleanstate "✔"


#prompt w/ abbreviated username, PIPENV indicator, and git status
function fish_prompt --description 'Write out the prompt'
  if string length -q $USER > 10
    set abbreviated_user 'cc'
  else
    set abbreviated_user $USER
  end

  printf '%s@%s:%s%s%s%s$ ' $abbreviated_user $__fish_prompt_hostname
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)
  if test -n "$PIPENV_ACTIVE"
      set_color cyan
      echo -n "(pipenv) "
      set_color normal
  end
  
  set_color normal
end

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
  status --is-command-substitution; and return

  # are we inside a git directory?
  if git rev-parse --show-toplevel &>/dev/null
    set gitdir (realpath (git rev-parse --show-toplevel))
    set cwd (pwd -P)
    # find the closest virtualenv starting from the current dir
    while string match "$gitdir*" "$cwd" &>/dev/null
      if test -e "$cwd/.venv/bin/activate.fish"
        source "$cwd/.venv/bin/activate.fish" &>/dev/null 
        return
      else
        set cwd (path dirname "$cwd")
      end
    end
  end
  # If virtualenv activated but we are not in a git directory, deactivate.
  if test -n "$VIRTUAL_ENV"
    if functions -q deactivate
      deactivate
    end
  end
end

__auto_source_venv

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<