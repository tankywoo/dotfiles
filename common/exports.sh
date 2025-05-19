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

if command -v pyenv >/dev/null 2>&1; then
    pathprepend_f "$(pyenv root)/shims"
fi
normalize_path


# -------------------------------------------------------------------------------
# other environment variables
# -------------------------------------------------------------------------------
export TZ='Asia/Shanghai'
export EDITOR='vim'
export LANG='en_US.UTF-8'
export LESS='-RS'

if [[ "$SHELL" == $(which zsh 2>/dev/null) ]]; then
    export HISTFILE=~/.zsh_history
    export SAVEHIST=99999
    setopt extendedhistory
    alias history='fc -l -i 1'  # defult: aliased to fc -l 1
elif [[ "$SHELL" == $(which bash 2>/dev/null) ]]; then
    shopt -s histappend                      # 允许多个会话同时写入历史文件而不覆盖
    export HISTFILE=~/.bash_history
    export HISTFILESIZE=99999
    export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
    # export PROMPT_COMMAND='history -a; history -n; history -w; '"$PROMPT_COMMAND"
    export HISTIGNORE='ls:bg:fg'

    # 异步同步函数
    async_sync_history() {
        # 立即异步追加当前命令（不阻塞）
        (history -a &) &> /dev/null

        # 每 5 秒异步加载其他终端的命令（避免频繁操作）
        if [[ -z "$LAST_HIST_SYNC" || $((SECONDS - LAST_HIST_SYNC)) -ge 5 ]]; then
            (history -n &) &> /dev/null
            LAST_HIST_SYNC=$SECONDS
        fi
    }

    # 兼容 bash-it（如果使用）
    if command -v safe_append_prompt_command &> /dev/null; then
        safe_append_prompt_command async_sync_history
    else
        PROMPT_COMMAND="async_sync_history${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
    fi

fi
export HISTSIZE=99999
