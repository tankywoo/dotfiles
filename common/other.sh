# rbenv; Octopress
if command -v rbenv 2>/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# rvm
pathappend $HOME/.rvm/bin  # Add RVM to PATH for scripting

# for Mac new Python
if [[ "$(uname)" == "Darwin" ]]; then
  pathappend $HOME/Library/Python/2.7/bin
fi

# disable CTRL+S from sending XOFF
stty ixany
stty ixoff -ixon
