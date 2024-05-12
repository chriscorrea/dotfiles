#abbr for navigation
abbr .. 'cd ..'
abbr ... 'cd ../..'

#abbr for ls 
abbr l 'ls -Fogh'
abbr lsa 'ls -Fogsa'
abbr recent 'ls -Fogrt --color=always | tail -10'
abbr oldest 'ls -Fogrt --color=always | head -10'

#abbr to jump to frequently-used directories
abbr cdh 'cd ~'
abbr cdd 'cd ~/Documents'
abbr cdp 'cd ~/Projects'
abbr cdl 'cd ~/Downloads'

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
  #if test (string length -q $USER) -ge 10
  if test (string length $USER) -gt 17
    set abbreviated_user 'cc'
  else
    set abbreviated_user $USER
  end

  set_color brblack
  printf '%s@%s:%s%s%s%s$ ' $abbreviated_user $__fish_prompt_hostname
  set_color $fish_color_cwd
  printf '%s' (prompt_pwd)
  set_color normal

  printf '%s ' (__fish_git_prompt)
  if test -n "$PIPENV_ACTIVE"
      set_color 62A
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
  #If Pipfile exists, show a message
  if test -e "Pipfile" -a -z "$PIPENV_ACTIVE"
    set_color magenta 
    echo "🐟 Run 'pipenv shell' to activate virtualenv"
    set_color normal
  end
end

__auto_source_venv

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
#eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<
