#!/bin/bash
# Tanky Woo @ 2013-10-18 00:19:56

dry_run=1
if [ "$1" == "-f" ]; then
    dry_run=0
fi

if [ "$dry_run" -eq 1 ]; then
    echo "=== DRY RUN MODE ==="
fi

remove_symlink() {
    dotfile=$1
    if ! [ -e $dotfile ]; then
        # echo "Ignore as symlink $dotfile not exists"
        return
    fi

    if [ -h $dotfile ]; then
        echo "Delete symlink $dotfile"
        if [ "$dry_run" -eq 0 ]; then
            rm -f $dotfile
        fi
    else
        echo "Keep $dotfile as it's not a symlink"
    fi
}

dotfiles=(
".zshrc"
".tmux.conf"
".vimrc"
".gitconfig"
".screenrc"
"tools"
".common"
"tmux.sh"
".zsh"
".pip/pip.conf"
)
for dotfile in "${dotfiles[@]}"
do
    remove_symlink $HOME/$dotfile
done

echo "Delete ${HOME}/.custom manually"
