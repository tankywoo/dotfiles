# Use the default config, them overwrite it.
. ~/.oh-my-zsh/templates/zshrc.zsh-template

ZSH_THEME="tanky"
DISABLE_CORRECTION="true"
DISABLE_AUTO_TITLE="true"

plugins=(git svn python colored-man tmux git-flow)

ZSH=$HOME/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

source ~/.zsh/exports.zsh
source ~/.zsh/aliases.zsh
source ~/.zsh/functions.zsh
source ~/.zsh/history.zsh
source ~/.zsh/quickjump.zsh

# disable CTRL+S from sending XOFF
stty ixany
stty ixoff -ixon

# rbenv; Octopress
if command -v rbenv 2>/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# rvm
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting

# virtualenvwrapper
# default $WORKON_HOME is ~/.virtualenvs after source virtualenvwrapper.sh
#export WORKON_HOME=~/Envs
VIRTUALENVWRAPPER="/usr/local/bin/virtualenvwrapper.sh"
if [ -e "${VIRTUALENVWRAPPER}" ]; then
	source ${VIRTUALENVWRAPPER}
fi
