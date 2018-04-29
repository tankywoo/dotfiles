# rbenv; Octopress
if command -v rbenv 2>/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# rvm
export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

# for Mac new Python
export PATH=$HOME/Library/Python/2.7/bin:$PATH

# virtualenvwrapper
# default $WORKON_HOME is ~/.virtualenvs after source virtualenvwrapper.sh
#export WORKON_HOME=~/Envs
VIRTUALENVWRAPPER_UBUNTU="/usr/local/bin/virtualenvwrapper.sh"
VIRTUALENVWRAPPER_GENTOO="/usr/bin/virtualenvwrapper.sh"
VIRTUALENVWRAPPER_PIP_USER="~/.local/bin/virtualenvwrapper.sh"
if [ -e "${VIRTUALENVWRAPPER_UBUNTU}" ]; then
	source ${VIRTUALENVWRAPPER_UBUNTU}
elif [ -e "${VIRTUALENVWRAPPER_GENTOO}" ]; then
	source ${VIRTUALENVWRAPPER_GENTOO}
elif [ -e "${VIRTUALENVWRAPPER_PIP_USER}" ]; then
	source ${VIRTUALENVWRAPPER_PIP_USER}
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

# disable CTRL+S from sending XOFF
stty ixany
stty ixoff -ixon

# added by travis gem
[ -f /Users/TankyWoo/.travis/travis.sh ] && source /Users/TankyWoo/.travis/travis.sh
