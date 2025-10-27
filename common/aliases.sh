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

alias simpleps="gsed -i \"s|BASH_IT_THEME='candy_modified'|BASH_IT_THEME='simpleps'|g\" $HOME/.dotfiles/bash/bashrc; bash-it reload"
alias unsimpleps="gsed -i \"s|BASH_IT_THEME='simpleps'|BASH_IT_THEME='candy_modified'|g\" $HOME/.dotfiles/bash/bashrc; bash-it reload"
