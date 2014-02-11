# Dotfiles #

My dotfiles for:

* vim
* tmux
* screen
* zsh(with theme)
* git
* sublime

## Quick Install & Uninstall ##

Before Install, make sure you have installed zsh.

Install:

	./setup.sh

Uninstall:

	./uninstall.sh

## State ##

Current the configurations and install script have been tested to work on:

* Gentoo
* Ubuntu 12.04
* LinuxMint 15
* Mac OS 10.9.1

If you use Mac OS, open `.zsh/aliases.zsh`, comment the line:

	alias ls='ls --color=auto'

and then uncomment:

	alias ls='ls -hG'

I think there will a better way to color ls command, but I can't find...

If there are problems on other platforms, please contact me, thanks.

## Contact ##

[Tanky Woo](http://tech.wutianqi.com/) <me@tankywoo.com>
