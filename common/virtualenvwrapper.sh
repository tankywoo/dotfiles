# -------------------------------------------------------------------------------
# An virtualenv enhanced tool
# ref:
# - <https://virtualenvwrapper.readthedocs.io/en/latest/>
# - <http://docs.python-guide.org/en/latest/dev/virtualenvs/#virtualenvwrapper>
# -------------------------------------------------------------------------------

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

