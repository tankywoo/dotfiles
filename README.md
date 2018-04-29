# Dotfiles #

> **WARNING: 2018-04-29, THE STRUCTURE OF REPOSITORY HAS BEEN CHANGED, IF YOU PULLED, YOU SHOULD RE-SYMLINK THE DOTFILES**

My dotfiles for: `bash`, `zsh`, `vim`, `git`, `tmux`, `screen` and useful tools, etc.


## Install & Uninstall ##

> **READ BEFORE YOU RUN THESE SCRIPTS**

Before Install, make sure you have installed zsh.

Install:

	./setup.sh

Uninstall:

	./uninstall.sh


## Usage  ##

`common/aliases.sh`:
- `treepy`: `tree` exclude `.pyc`
- `json`: pretty print json file
- `ccat`: cat code with color
- `mux`: alias [tmuxinator](https://github.com/tmuxinator/tmuxinator)
- `mac-listen`: `netstat -tlnp` under macOS

`common/functions.sh`:
- `pycd`: quick cd to python source package directory
- `set-tab`: change terminal tab's title
- `mdv`: markdown preview in terminal, [mdv](https://github.com/axiros/terminal_markdown_viewer)
- `wanip`: get outer ip in private network
- `getip`: get geo ip
- `man`: man with color

`common/virtualenvwrapper.sh`: source virtualenvwrapper script

`common/ssh-agent-wrapper.sh`: auto start ssh agent to load private key

`git/gitconfig`: user global configuration. `git diff` with `diff-highlight` tool, set some alias shortkey, and colors for status

`pip/pip.conf`: set pypi mirror for [ustc.edu.cn](https://mirrors.ustc.edu.cn/pypi/web/) or [douban](http://pypi.doubanio.com/)

`tmux/tmux.conf`: set prefix key with `control + a` instead default `control + b`, for compatible with `screen`

`tools/tmux-multi.sh`: get hosts list file as arg, auto quick start tmux window with multiple panes, each pane with one host login by ssh, and operate these hosts synchronized.

`tools/256-color.sh`: display 256 colors in terminal


## State ##

Current the configurations and install script have been tested to work on:

* Gentoo
* Mac OS >= 10.9
* Ubuntu >= 12.04

If there are problems on other platforms, please contact me, thanks.


## Contact ##

- HOMEPAGE: [Tanky Woo](http://tankywoo.com/)
- EMAIL: <me@tankywoo.com>
