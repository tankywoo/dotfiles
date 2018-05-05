# http://jeroenjanssens.com/2013/08/16/quickly-navigate-your-filesystem-from-the-command-line.html
# This tool is used to quick jump
export MARKPATH=$HOME/.marks
function cda { 
    cd -P "$MARKPATH/$1" 2>/dev/null || echo "No such mark: $1"
}
function mark { 
    mkdir -p "$MARKPATH"; ln -s "$(pwd)" "$MARKPATH/$1"
}
function unmark { 
    rm -i "$MARKPATH/$1"
}
function marks {
    ls -l "$MARKPATH" | sed 's/  / /g' | cut -d' ' -f9- | sed 's/ -/\t-/g' && echo
}
function _completemarks {
  reply=($(ls $MARKPATH))
}

if [[ "$SHELL" == */"bash" ]]; then
    _completemarks() {
      local curw=${COMP_WORDS[COMP_CWORD]}
      local wordlist=$(find $MARKPATH -type l -printf "%f\n")
      COMPREPLY=($(compgen -W '${wordlist[@]}' -- "$curw"))
      return 0
    }

    complete -F _completemarks jump unmark
elif [[ "$SHELL" == */"zsh" ]]; then
    compctl -K _completemarks cda
    compctl -K _completemarks unmark
fi
