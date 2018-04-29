# rbenv; Octopress
if command -v rbenv 2>/dev/null; then
	export PATH="$HOME/.rbenv/bin:$PATH"
	eval "$(rbenv init -)"
fi

# rvm
export PATH=$HOME/.rvm/bin:$PATH # Add RVM to PATH for scripting

# for Mac new Python
export PATH=$HOME/Library/Python/2.7/bin:$PATH

# disable CTRL+S from sending XOFF
stty ixany
stty ixoff -ixon
