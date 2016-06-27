#!/bin/bash
# Tanky Woo @ 2013-10-18 00:19:56

HOME=${HOME}

dotfiles=(".zshrc" ".tmux.conf" ".vimrc" ".gitconfig" ".screenrc")
for dotfile in "${dotfiles[@]}"
do
	rm -f ${HOME}/${dotfile}
	echo "Delete symlink ${HOME}/${dotfile}"
done

rm -f ${HOME}/tmux.sh
echo "Delete symlink ${HOME}/tmux.sh"
rm -f ${HOME}/.zsh
echo "Delete symlink ${HOME}/.zsh"
rm -f ${HOME}/.pip/pip.conf
rmdir ${HOME}/.pip
echo "Delete symlink ${HOME}/.pip/pip.conf"
