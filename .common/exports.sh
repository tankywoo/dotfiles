# xterm hack for some terminals to support 256 colors

# If not set null_glob option, when '/usr/share/terminfo/*/xterm-256color'
# not exists, will output: no matches found: /usr/share/terminfo/*/xterm-256color
# more detailed see this answer: http://unix.stackexchange.com/a/26825/45725
if [[ "$SHELL" == `which zsh`   ]]; then
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
