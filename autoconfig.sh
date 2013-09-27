#!/bin/bash

HOME=${HOME}
PWD=`pwd`
OH_MY_ZSH=${HOME}"/.oh-my-zsh"

# Screen
ln -sf ${PWD}/.screenrc ${HOME}/.screenrc

# Zsh
# First need to install `zsh`
# Then clone oh-my-zsh
# git clone git@github.com:robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
ln -sf ${PWD}/.zshrc ${HOME}/.zshrc
ln -sf ${PWD}/tanky.zsh-theme ${OH_MY_ZSH}/themes/tanky.zsh-theme # TODO: See ~/.oh-my-zsh/custom/
chsh -s /bin/zsh
source ~/.zshrc

# Tmux
ln -sf ${PWD}/.tmux.conf ${HOME}/.tmux.conf
ln -sf ${PWD}/tmux.sh ${HOME}/tmux.sh # TODO, use alise?

# Vim
# First install `Vundle`
# git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
# vim +BundleInstall +qall
ln -sf ${PWD}/.vimrc ${HOME}/.vimrc

# Git
ln -sf ${PWD}/.gitconfig ${HOME}/.gitconfig
