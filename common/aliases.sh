# shellcheck shell=bash

alias ls='ls --color=auto'
alias ll='ls -al'
alias lls='ls -alSh'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias tmux="tmux -2"
alias vix='vim --cmd "set expandtab"'
alias treepy='tree -I "*.pyc"'
alias json="python -mjson.tool"
alias ccat="pygmentize -f terminal256 -O style=monokai -g"
alias mux="tmuxinator"

#@bug: fc -l cause fzf works wrong
#alias history='fc -l'  # defult: aliased to fc -l 1
#export HISTTIMEFORMAT='%F %T' # for Bash only
if [[ "$SHELL" == $(which zsh 2>/dev/null) ]]; then
HISTFILE=~/.zsh_history
elif [[ "$SHELL" == $(which bash 2>/dev/null) ]]; then
HISTFILE=~/.bash_history
fi
HISTSIZE=9999
SAVEHIST=9999
if [[ "$SHELL" == `which zsh 2>/dev/null` ]]; then
    setopt extendedhistory
fi

if [[ "$(uname)" == "Darwin" ]]; then
	alias mac-listen='sudo lsof -i -n -P | grep TCP'
fi
