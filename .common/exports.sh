# xterm hack for some terminals to support 256 colors

# If not set null_glob option, when '/usr/share/terminfo/*/xterm-256color'
# not exists, will output: no matches found: /usr/share/terminfo/*/xterm-256color
# more detailed see this answer: http://unix.stackexchange.com/a/26825/45725
if [[ "$SHELL" == `which zsh 2>/dev/null`   ]]; then
	setopt null_glob
fi

if [ -z "$TMUX" ] && [[ "$TERM" =~ "xterm" ]]; then
	if [ -e /usr/share/terminfo/*/xterm-256color ]; then
		export TERM='xterm-256color'
	else
		export TERM='xterm-color'
	fi
elif [ -n "$TMUX" ]; then
	if [ -e /usr/share/terminfo/*/screen-256color ]; then
		export TERM='screen-256color'
	else
		export TERM='screen'
	fi
fi
export PATH=${HOME}/.local/bin:/usr/local/bin:/usr/local/sbin:${PATH}
export TZ='Asia/Shanghai'
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-RS'

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
