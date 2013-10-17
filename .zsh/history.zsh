# History command
alias history='fc -l'  # defult: aliased to fc -l 1
#export HISTTIMEFORMAT='%F %T' # for Bash only
HISTFILE=~/.zsh_history
HISTSIZE=9999
SAVEHIST=9999
setopt extendedhistory
