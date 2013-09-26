#!/bin/zsh
# Tanky Woo <me@tankywoo.com>

# 
SESSION_NAME='dev'
WINDOWS_NAME1='tankywoo'
WINDOWS_NAME2='ops-dev'

source ~/.zshrc
tmux='tmux -2'

tmux start-server

if ! $(tmux has-session -t ${SESSION_NAME}); then
	tmux new-session -d -s ${SESSION_NAME} -n ${WINDOWS_NAME1} # -d is important

	tmux select-window -t ${WINDOWS_NAME1}
	tmux split-window -h -p 60
	tmux select-pane -t 0
	tmux split-window -v -p 25
	tmux send-keys -t 0 'ipython' C-m
	# The C-m at the end is interpreted by Tmux as the enter key.

	tmux new-window -n ${WINDOWS_NAME2}

	tmux select-window -t ${WINDOWS_NAME1}
	tmux select-pane -t 2
fi

tmux attach-session -d -t ${SESSION_NAME}
