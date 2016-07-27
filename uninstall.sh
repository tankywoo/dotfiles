#!/bin/bash
# Tanky Woo @ 2013-10-18 00:19:56

HOME=${HOME}

dotfiles=(".zshrc" ".tmux.conf" ".vimrc" ".gitconfig" ".screenrc")
for dotfile in "${dotfiles[@]}"
do
	echo "Delete symlink ${HOME}/${dotfile}"
	rm -f ${HOME}/${dotfile}
done

echo "Delete symlink ${HOME}/tools"
rm -f ${HOME}/tools

echo "Delete symlink ${HOME}/.common"
rm -f ${HOME}/.common

echo "Delete symlink ${HOME}/tmux.sh"
rm -f ${HOME}/tmux.sh

echo "Delete symlink ${HOME}/.zsh"
rm -f ${HOME}/.zsh

echo "Delete symlink ${HOME}/.pip/pip.conf"
rm -f ${HOME}/.pip/pip.conf
rmdir ${HOME}/.pip
