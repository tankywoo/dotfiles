# xterm hack for some terminals to support 256 colors
if [ "$TERM" = "xterm" ]; then
	if [ -e /usr/share/terminfo/x/xterm-256color ]; then
		export TERM='xterm-256color'
	else
		export TERM='xterm-color'
	fi
fi

export TERM='xterm-256color'
export PATH=${PATH}:/sbin:/usr/local/bin:
export TZ='Asia/Shanghai'
export EDITOR='vim'
export LANG='en_US.UTF-8'
