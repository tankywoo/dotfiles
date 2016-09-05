if [[ $EUID -ne 0  ]]; then
    SUDO=sudo
fi

# Quick jump to Python package directory
pycd(){ cd $(dirname $(python -c "print __import__('$1').__file__")); }

# Simplify ntpdate command
ntpupdate(){ $SUDO ntpdate cn.pool.ntp.org; }
#ntpupdate(){ $SUDO ntpdate jp.pool.ntp.org; }

i(){ curl ip.cn/$i; }


# -------------------------------------------------------------------------------
# set window/tab title
# $1 = type; 0 - both, 1 - tab, 2 - title
# ref:
#   - Change iTerm2 window and tab titles in zsh
#   - http://superuser.com/questions/419775/with-bash-iterm2-how-to-name-tabs
# `echo -ne "\e]1;your title\a"` for simple
# TODO not work under tmux
# -------------------------------------------------------------------------------
setTerminalText() {
  local mode=$1 ; shift
  echo -ne "\033]$mode;$@\007"
}
set-both() { setTerminalText 0 $@; }
set-tab() { setTerminalText 1 $@; }
set-window() { setTerminalText 2 $@; }
