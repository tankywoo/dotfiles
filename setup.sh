#!/bin/zsh

# First, **make sure** all the softwares have been installed.
#	* zsh
#	* tmux
#	* vim
#	* git
#	* screen
#	* tig

HOME=${HOME}
PWD=`pwd`
OH_MY_ZSH=${HOME}"/.oh-my-zsh"
VUNDLE=${HOME}"/.vim/bundle/Vundle.vim"

# Pre check
check_software_exist(){
	softwares=("zsh" "tmux" "vim" "git" "screen")
	for sw in "${softwares[@]}"
	do
		# Notice the semicolon
		type ${sw} > /dev/null 2>&1 || 
			{ echo >&2 "ERROR: **${sw}** is not installed!"; exit 1; }
	done
}

create_symlinks(){
	dotfiles=(".zshrc" ".tmux.conf" ".vimrc" ".gitconfig" ".screenrc", ".tigrc")
	for dotfile in "${dotfiles[@]}"
	do
		ln -sf ${PWD}/${dotfile} ${HOME}/${dotfile}
		echo "Create symlink ${HOME}/${dotfile}"
	done
}

install_oh_my_zsh(){
	if [ -d "${OH_MY_ZSH}"  ]; then
		cd "${OH_MY_ZSH}"
		echo "Change directory to `pwd`"
		echo "${OH_MY_ZSH} exists. Git pull to update..."
		git pull
		cd - > /dev/null 2>&1
		echo "Change directory back to `pwd`"
	else
		echo "${OH_MY_ZSH} not exists. Install..."
		#git clone git@github.com:robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
		#wget --no-check-certificate http://install.ohmyz.sh -O - | sh
		git clone https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh
	fi
}

# Vim install `Vundle` and plugins
install_vundle(){
	if [ -d "${VUNDLE}" ]; then
		cd "${VUNDLE}"
		echo "Change directory to `pwd`"
		echo "${VUNDLE} exists. Git pull to update..."
		git pull
		cd - > /dev/null 2>&1
		echo "Change directory back to `pwd`"
	else
		echo "${VUNDLE} not exists. Git clone to create..."
		git clone https://github.com/gmarik/Vundle.vim.git ${VUNDLE}
		vim +BundleInstall +qall
	fi
}

config_zsh(){
	echo "Create symlink ${HOME}/.zsh"
	ln -sf ${PWD}/.zsh ${HOME}/.zsh
	# TODO: See ~/.oh-my-zsh/custom/
	ln -sf ${PWD}/tanky.zsh-theme ${OH_MY_ZSH}/themes/tanky.zsh-theme
	chsh -s `which zsh` # TODO: If zsh is an alias?
	source ${HOME}/.zshrc
}

config_tmux(){
	echo "Create symlink ${HOME}/tmux.sh"
	ln -sf ${PWD}/tmux.sh ${HOME}/tmux.sh # TODO, use alise?
}

main(){
	check_software_exist
	install_oh_my_zsh
	install_vundle
	create_symlinks
	config_zsh
	config_tmux
}

main

echo "[SETUP OK]"
