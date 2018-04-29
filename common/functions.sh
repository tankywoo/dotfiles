if [[ $EUID -ne 0  ]]; then
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
#ntpupdate(){ $SUDO ntpdate jp.pool.ntp.org; }

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

# -------------------------------------------------------------------------------
# mdv is a python tool, markdown preview under terminal
# -------------------------------------------------------------------------------
mdv_path=`command -v mdv`
if [ $? -eq 0 ]; then
    mdv() { $mdv_path $@ | less; }
fi

# -------------------------------------------------------------------------------
# wanip get the external ip
# ref: http://unix.stackexchange.com/questions/22615/how-can-i-get-my-external-ip-address-in-a-shell-script
# -------------------------------------------------------------------------------
wanip() { dig +short myip.opendns.com @resolver1.opendns.com }

# -------------------------------------------------------------------------------
# Geo lookup
# -------------------------------------------------------------------------------
geoip(){ curl ip.cn/$1; }

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
