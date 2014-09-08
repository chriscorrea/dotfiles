# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="blinks"

# Example aliases
alias zshconfig="vi ~/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias -g npm="cmd /c npm"
alias -g gem="C:/Ruby193/bin/gem"
alias -g ruby="C:/Ruby193/bin/ruby"
#alias -g irb="/cygdrive/c/Ruby193/bin/irb.bat"

#directory mappings
alias cdw="cd ~/Documents/\~Workspace"
alias cdd="cd ~/Documents/"	
alias cdh="cd ~/"
alias cdv="cd ~/Documents/Development/"

#map vi (v 7.3.* to vim 7.4.*)
alias -g vi="vim"
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
alias -g recent='ls -AlsGt | zmore '

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby bower colorize gem github gnu-utils history node npm nvm python pip rake redis-cli sublime web-search)


source $ZSH/oh-my-zsh.sh

# Customize to your needs...
