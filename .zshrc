# Use the default config, them overwrite it.
. ~/.oh-my-zsh/templates/zshrc.zsh-template

ZSH_THEME="tanky"
DISABLE_CORRECTION="true"
DISABLE_AUTO_TITLE="true"
DISABLE_AUTO_UPDATE="true"

PS1_ENABLE_USERNAME="true"
PS1_ENABLE_HOSTNAME="false"
PS1_BOLD_PRE="false"

# tmuxinator is completion script almost like offical
plugins=(git svn python colored-man tmux git-flow autojump tmuxinator)

# TODO, get path by command
WORK_DIR="$HOME/.dotfiles/"
PRE_CUSTOM="${WORK_DIR}/custom/pre_custom.zsh"
if [ -e "${PRE_CUSTOM}" ]; then
    source ${PRE_CUSTOM}
fi

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
VIRTUALENVWRAPPER_UBUNTU="/usr/local/bin/virtualenvwrapper.sh"
VIRTUALENVWRAPPER_GENTOO="/usr/bin/virtualenvwrapper.sh"
if [ -e "${VIRTUALENVWRAPPER_UBUNTU}" ]; then
	source ${VIRTUALENVWRAPPER_UBUNTU}
elif [ -e "${VIRTUALENVWRAPPER_GENTOO}" ]; then
	source ${VIRTUALENVWRAPPER_GENTOO}
fi

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
	echo "Initializing new SSH agent..."
	/usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
	echo succeeded
	chmod 600 "${SSH_ENV}"
	. "${SSH_ENV}" > /dev/null
	/usr/bin/ssh-add;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
	. "${SSH_ENV}" > /dev/null
	#ps ${SSH_AGENT_PID} doesn't work under cywgin
	ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
	start_agent;
}
else
	start_agent;
fi

POST_CUSTOM="${WORK_DIR}/custom/post_custom.zsh"
if [ -e "${POST_CUSTOM}" ]; then
    source ${POST_CUSTOM}
fi
