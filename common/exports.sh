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
pathprepend_f /opt/homebrew/bin /opt/homebrew/sbin
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
elif [[ "$SHELL" == $(command -v bash 2>/dev/null) ]]; then
    shopt -s histappend                      # 允许多个会话同时写入历史文件而不覆盖
    export HISTFILE=~/.bash_history
    export HISTFILESIZE=99999
    export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S "
    # export PROMPT_COMMAND='history -a; history -n; history -w; '"$PROMPT_COMMAND"
    export HISTIGNORE='ls:bg:fg'

    ## 更健壮的、基于锁的历史同步函数
    #safe_sync_history() {
    #    local lock_dir="${TMPDIR:-/tmp}/bash_history.lock"

    #    # 尝试获取锁。如果mkdir失败，说明另一个同步正在运行，则直接退出。
    #    if mkdir "$lock_dir" 2>/dev/null; then
    #        # 确保脚本被中断时也能移除锁，避免死锁。
    #        trap 'rmdir "$lock_dir" 2>/dev/null' INT TERM EXIT

    #        # 获取锁后，安全地执行历史操作。
    #        history -a  # 将当前会话的新命令追加到历史文件
    #        history -n  # 从历史文件中读取其他会话写入的新命令

    #        # 任务完成，释放锁并清除陷阱。
    #        rmdir "$lock_dir" 2>/dev/null
    #        trap - INT TERM EXIT
    #    fi
    #}

    ## 兼容 bash-it（如果使用）
    #if command -v safe_append_prompt_command &> /dev/null; then
    #    safe_append_prompt_command safe_sync_history
    #else
    #    PROMPT_COMMAND="safe_sync_history${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
    #fi

fi
export HISTSIZE=99999
