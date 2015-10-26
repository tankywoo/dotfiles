# xterm hack for some terminals to support 256 colors

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
export PATH=${PATH}:/sbin:/usr/local/bin:/usr/local/sbin:${HOME}/.local/bin/:
export TZ='Asia/Shanghai'
export EDITOR='vim'
export LANG='en_US.UTF-8'
