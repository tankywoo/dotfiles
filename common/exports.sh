# shellcheck shell=bash
# -------------------------------------------------------------------------------
# xterm settings
# -------------------------------------------------------------------------------
# xterm hack for some terminals to support 256 colors

if [ -z "$TMUX" ] && [[ "$TERM" =~ "xterm" ]]; then
	if ls /usr/share/terminfo/*/xterm-256color >/dev/null 2>&1; then
		export TERM='xterm-256color'
	else
		export TERM='xterm-color'
	fi
elif [ -n "$TMUX" ]; then
	if ls /usr/share/terminfo/*/screen-256color >/dev/null 2>&1; then
		export TERM='screen-256color'
	else
		export TERM='screen'
	fi
fi

# -------------------------------------------------------------------------------
# $PATH settings
# -------------------------------------------------------------------------------
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
  for ((i=$(($# - 1)); i>=0; i--));
  do
    _path=${_paths[*]:$i:1}  # for bash & zsh, https://stackoverflow.com/a/56311706/1276501
    if [ -d "$_path" ] && [[ ":$PATH:" != *":$_path:"* ]]; then
        PATH="$_path${PATH:+":$PATH"}"
    fi
    export PATH
  done
}

pathprepend_f() {
  # force prepend path no matter if it already exists in $PATH
  _paths=("$@")
  for ((i=$(($# - 1)); i>=0; i--));
  do
    _path=${_paths[*]:$i:1}  # for bash & zsh, https://stackoverflow.com/a/56311706/1276501
    if [ -d "$_path" ]; then
        PATH="$_path${PATH:+":$PATH"}"
    fi
    export PATH
  done
}

normalize_path() {
  # remove duplicate items in $PATH
  # shell will auto add some path to $PATH, which cause duplicate paths
  paths=""
  declare -a _paths=( $(echo $PATH | tr ':' ' ') )
  for _path in "${_paths[@]}"; do
    if [[ ":$paths:" != *":$_path:"* ]]; then
      paths="${paths:+"$paths:"}$_path"
    fi
  done
  unset PATH
  # should export, or behave strangely under darwin bash, like which command
  export PATH=$paths
}

pathprepend_f /usr/local/bin /usr/local/sbin
pathprepend /bin /usr/bin /sbin /usr/sbin
normalize_path


# -------------------------------------------------------------------------------
# other environment variables
# -------------------------------------------------------------------------------
export TZ='Asia/Shanghai'
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-RS'
