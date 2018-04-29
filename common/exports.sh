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

# refer to: http://superuser.com/questions/39751/add-directory-to-path-if-its-not-already-there
pathappend() {
  for _path in "$@"
  do
    if [ -d "$_path" ] && [[ ":$PATH:" != *":$_path:"* ]]; then
        PATH="${PATH:+"$PATH:"}$_path"
    fi
  done
}

pathprepend() {
  _paths=("$@")
  for ((i=$#; i>0; i--)); 
  do
    _path=${_paths[$i]}  # for bash & zsh
    if [ -d "$_path" ] && [[ ":$PATH:" != *":$_path:"* ]]; then
        PATH="$_path${PATH:+":$PATH"}"
    fi
  done
}

export GOPATH=${HOME}/.go
pathprepend $GOPATH/bin ${HOME}/.local/bin ${HOME}/.local/bin /usr/local/sbin /usr/sbin /sbin

export TZ='Asia/Shanghai'
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-RS'
