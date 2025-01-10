# shellcheck shell=bash

if [[ $EUID -ne 0 ]]; then
    SUDO=sudo
fi

# -------------------------------------------------------------------------------
# Quick jump to Python package directory
# -------------------------------------------------------------------------------
pycd(){ cd $(dirname $(python -c "print __import__('$1').__file__")); }

# -------------------------------------------------------------------------------
# Simplify ntpdate command
# -------------------------------------------------------------------------------
ntpupdate(){ $SUDO ntpdate cn.pool.ntp.org; }

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
set_both() { setTerminalText 0 $@; }
set_tab() { setTerminalText 1 $@; }
set_window() { setTerminalText 2 $@; }

# -------------------------------------------------------------------------------
# mdv is a python tool, markdown preview under terminal
# -------------------------------------------------------------------------------
mdv_path=`command -v mdv`
if [ $? -eq 0 ]; then
    mdv() { $mdv_path $@ | less; }
fi

# -------------------------------------------------------------------------------
# wanip get the external ip
# @todo
# -------------------------------------------------------------------------------
wanip() { :; }

# -------------------------------------------------------------------------------
# Geo lookup
# @todo
# -------------------------------------------------------------------------------
geoip() { :; }

# -------------------------------------------------------------------------------
# colored man
# -------------------------------------------------------------------------------
# Fix colored man pages not work
# * http://unix.stackexchange.com/questions/6010/colored-man-pages-not-working-on-gentoo
# * https://forums.gentoo.org/viewtopic-t-819833-start-0.html
export GROFF_NO_SGR=1
# Overwrite man with different color
man() {
	env \
		LESS_TERMCAP_mb=$(printf "\e[1;34m") \
		LESS_TERMCAP_md=$(printf "\e[1;34m") \
		LESS_TERMCAP_me=$(printf "\e[0m") \
		LESS_TERMCAP_se=$(printf "\e[0m") \
		LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
		LESS_TERMCAP_ue=$(printf "\e[0m") \
		LESS_TERMCAP_us=$(printf "\e[1;32m") \
		PAGER="${commands[less]:-$PAGER}" \
		_NROFF_U=1 \
		PATH="$HOME/bin:$PATH" \
			man "$@"
}


proxy() {
    export http_proxy=socks5://127.0.0.1:7897;
    export https_proxy=socks5://127.0.0.1:7897;
    export all_proxy=socks5://127.0.0.1:7897;
    export no_proxy=socks5://127.0.0.1:7897;
    export HTTP_PROXY=socks5://127.0.0.1:7897;
    export HTTPS_PROXY=socks5://127.0.0.1:7897;
    export ALL_PROXY=socks5://127.0.0.1:7897;
    export NO_PROXY=socks5://127.0.0.1:7897;
}

unproxy() {
    unset http_proxy;
    unset https_proxy;
    unset all_proxy;
    unset no_proxy;
    unset HTTP_PROXY;
    unset HTTPS_PROXY;
    unset ALL_PROXY;
    unset NO_PROXY
}
