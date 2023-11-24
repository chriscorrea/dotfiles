#enable conda
#source "$HOME/opt/anaconda3/etc/fish/conf.d/conda.fish"
#source "(conda info --root)/etc/fish/conf.d/conda.fish"

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

set fish_greeting "🐟 🐟 🐟"


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



#github-friendly prompt
function fish_prompt --description 'Write out the prompt'
    printf '%s@%s:%s%s%s%s$ ' $USER $__fish_prompt_hostname
    set_color $fish_color_cwd
    printf '%s' (prompt_pwd)
    set_color normal

    printf '%s ' (__fish_git_prompt)

    set_color normal
end

function __auto_source_venv --on-variable PWD --description "Activate/Deactivate virtualenv on directory change"
  status --is-command-substitution; and return

  # Check if we are inside a git repository
  if git rev-parse --show-toplevel &>/dev/null
    set dir (realpath (git rev-parse --show-toplevel))
  else
    set dir (pwd)
  end

  # Find a virtual environment in the directory
  set VENV_DIR_NAMES env .env venv .venv
  for venv_dir in $dir/$VENV_DIR_NAMES
    if test -e "$venv_dir/bin/activate.fish"
      break
    end
  end

  # Activate venv if it was found and not activated before
  if test "$VIRTUAL_ENV" != "$venv_dir" -a -e "$venv_dir/bin/activate.fish"
    source $venv_dir/bin/activate.fish
  # Deactivate venv if it is activated but the directory doesn't exist
  else if not test -z "$VIRTUAL_ENV" -o -e "$venv_dir"
    deactivate
  end
end

__auto_source_venv

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

