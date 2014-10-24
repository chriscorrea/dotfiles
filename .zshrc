# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="blinks"

# Basic aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias -g npm="cmd /c npm"
#alias -g gem="C:/Ruby193/bin/gem"
alias -g ruby="C:/Ruby193/bin/ruby"
alias -g julia="C:/Julia/bin/julia"
alias -g python="C:/Python34/python"
#alias -g sqlite3="C:/Sqlite3/sqlite3"
alias -g sqlite=sqlite3
alias -g cyg="alias cyg='apt-cyg -m http://mirrors.kernel.org/sources.redhat.com/cygwin/'"

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

alias -g 400='chmod 400'
alias -g 600='chmod 600'
alias -g 644='chmod 644'
alias -g 700='chmod 700'    
alias -g 755='chmod 755'
alias -g 777='chmod 777'


#alias -g google='ping -c 10240000 google.com'
alias -g find_file_name='find ./ -name'
 
alias -g lsa="ls -AlsG"
#alias -g recent='ls -AlsGt | zmore '
alias -g recent='ls -gathG | head -10 '
alias -g oldest='ls -gathG | tail -10'

#################################
## Reminders
#################################

alias tmux="tmux"
alias help.tmux="echo -e 'tmux new -s session_name | tmux attach -t session_name | tmux ls | tmux detach (prefix+d)\ntmux new-window (prefix+c) | tmux select-window -t 0-9 (prefix + #) | tmux rename-window (prefix+,) | tmux split-window -h\ntmux list-keys | tmux info  '  "
#alias -g help.awk="echo -e 'awk \'\/pattern\/ {print \"\$1\"}\'   '"
alias help.awk="echo -e 'awk' "

alias help.vim="echo -e '\"{a-zA-z0-9} prefix for named register | :reg[isters] | m{a-zA-z} to set mark | :marks\n:[range]s[ubstitute]/{pattern}/{string}/[c][e][g][p][r][i][I] [count] ' "


# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(colemak git ruby bower colorize gem github gnu-utils history node npm nvm python pip rake redis-cli sublime web-search)

source $ZSH/oh-my-zsh.sh
