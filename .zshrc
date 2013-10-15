# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="tanky" # Custom

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how many often would you like to wait before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true" # Custom

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true" # Custom

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git svn python colored-man tmux git-flow) # Custom

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

######################
# Custom @ Tanky Woo #
######################

export PATH=${PATH}:/sbin:/usr/local/bin:

# disable CTRL+S from sending XOFF
stty ixany
stty ixoff -ixon

TZ='Asia/Shanghai'; export TZ # Timezone

EDITOR='vim' # Default editor

export LANG='en_US.UTF-8'

alias ls='ls --color=auto'
alias ll='ls -al'
alias lls='ls -alSh'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias grep='grep --color'

alias treepy='tree -I "*.pyc"'

alias vix='vi --cmd "set expandtab"'

# Tmux
export TERM="xterm-256color"
alias tmux="tmux -2"

# History command
alias history='fc -l'  # defult: aliased to fc -l 1
#export HISTTIMEFORMAT='%F %T' # for Bash only
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999
setopt extendedhistory

# Command-Line Tools `t`
# https://github.com/tankywoo/t
alias t='python ~/.t/t.py --task-dir ~/.tasks --list tasks'
alias tpush='cd ~/.tasks/; git add tasks .tasks.done; git commit -m "add tasks"; git push; cd -'
alias tpull='cd ~/.tasks/; git pull; cd -'
alias tst='cd ~/.tasks/; git status; cd -'

# Quick jump to Python package directory
pycd(){ cd $(dirname $(python -c "print __import__('$1').__file__")); }

# Simplify ntpdate command
ntpupdate(){sudo ntpdate cn.pool.ntp.org}

# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
# This tool is used to quick jump
export MARKPATH=$HOME/.marks
function cda { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
function _completemarks {
  reply=($(ls $MARKPATH))

}
compctl -K _completemarks cda
compctl -K _completemarks unmark

# rbenv; Octopress
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# virtualenvwrapper
# default $WORKON_HOME is ~/.virtualenvs after source virtualenvwrapper.sh
#export WORKON_HOME=~/Envs
source /usr/local/bin/virtualenvwrapper.sh
