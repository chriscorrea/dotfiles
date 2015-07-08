# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
#ZSH_THEME="blinks"
ZSH_THEME="correa"

################################
## VIM Mode  
###############################

bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

precmd() { RPROMPT="" }

function zle-line-init zle-keymap-select {
   VIM_NORMAL="%{$fg_bold[red]%} [% NORMAL]%  %{$reset_color%}"
   RPS1="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/} $EPS1"
   zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

  #vim_mode="${${KEYMAP/vicmd/${vim_cmd_mode}}/(main|viins)/${vim_ins_mode}}"
#function zle-line-finish {
#  vim_mode=$vim_ins_mode
#}
#zle -N zle-line-finish

# Fix a bug when you C-c in CMD mode: http://paulgoscicki.com/archives/2012/09/vi-mode-indicator-in-zsh-prompt/
#function TRAPINT() {
#  vim_mode=$vim_ins_mode
#  return $(( 128 + $1 ))
#}

# reduce lag between modes (0.1s)
export KEYTIMEOUT=1

# Basic aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias  npm="cmd /c npm"
#alias -g gem="C:/Ruby193/bin/gem"
#alias  ruby="C:/Ruby193/bin/ruby"
alias  julia="C:/Julia/bin/julia"
#alias  python="C:/Python34/python"
#alias -g sqlite3="C:/Sqlite3/sqlite3"
alias  sqlite=sqlite3
alias  cyg="alias cyg='apt-cyg -m http://mirrors.kernel.org/sources.redhat.com/cygwin/'"

#aliasing all RubyGem wrappers
alias gem='gem.bat'
alias rake='rake.bat'
alias erb='erb.bat'
alias irb='irb.bat'
alias rdoc='rdoc.bat'
alias ri='ri.bat'
alias rspec='rspec.bat'
alias cucumber='cucumber.bat'
alias bundle='bundle.bat'

##############################
## Suffix Aliases
#############################
alias -s txt vim
alias -s mkd vim
alias -s rb vim
alias -s py vim
alias -s pdf xpdf
alias -s sql vim

#############################
## Aliases for directories
############################
hash -d doc=~/Documents
hash -d w=~/Documents/\~Workspace
hash -d h=~/Hive
hash -d s=~/Documents/\~Workspace\Scripts
hash -d dot=~/.dotfiles

#map vi (v 7.3.* to vim 7.4.*)
alias -g vi="vim"

#open all markdown files in directory in vim (for writing projects)
alias markup='vim *.mkd'

#alias -g irb="/cygdrive/c/Ruby193/bin/irb.bat"

#directory mappings
alias cdw="cd ~/Documents/\~Workspace"
alias cds="cd ~/Documents/\~Workspace/Scripts"
alias cdd="cd ~/Documents/"	
alias cdh="cd ~/"
alias cdv="cd ~/Documents/Development/"
alias cdbox="cd ~/Dropbox"

#quick directory navigation
alias -g ..="cd .."
alias -g ...="cd ../.."
alias -g ....="cd ../../.."

alias -g listening=lsof -Pan -i tcp -i udp

alias 400='chmod 400'
alias 600='chmod 600'
alias 644='chmod 644'
alias 700='chmod 700'    
alias 755='chmod 755'
alias 777='chmod 777'


#alias -g google='ping -c 10240000 google.com'
alias find_file_name='find ./ -name'
 
alias lsa="ls -AlsG"
#alias -g recent='ls -AlsGt | zmore '
alias recent='ls -gathG | head -10 '
alias oldest='ls -gathG | tail -10'

################################
## Term Config
################################

#force term-256
export TERM=xterm-256color
[ -n "$TMUX" ] && export TERM=screen-256color

#################################
## Reminders
#################################

alias tmux="tmux"
alias help.tmux="echo -e 'tmux new -s session_name | tmux attach -t session_name | tmux ls | tmux detach (prefix+d)\ntmux new-window (prefix+c) | tmux select-window -t 0-9 (prefix + #) | tmux rename-window (prefix+,) | tmux split-window -h\ntmux list-keys | tmux info  '  "
#alias -g help.awk="echo -e 'awk \'\/pattern\/ {print \"\$1\"}\'   '"
alias help.awk="echo -e 'awk' "

alias help.vim="echo -e '\"{a-zA-z0-9} prefix for named register | :reg[isters] | m{a-zA-z} to set mark | :marks\n:[range]s[ubstitute]/{pattern}/{string}/[c][e][g][p][r][i][I] [count] ' "

# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(colemak git ruby bower colorize gem github gnu-utils history node npm nvm python pip rake redis-cli sublime web-search vi-mode)

source $ZSH/oh-my-zsh.sh
