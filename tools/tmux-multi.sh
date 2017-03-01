#!/bin/bash
# ------------------------------------------------------------------
# Tanky Woo (2017-03-01)
# A Tmux ops tool, quick connect to multiple hosts listed in file.
# By default, the maximum hosts per window can split is 16, which
# is controlled by MAX_PANES variable, this number is related to
# your window's size, if you use small screen, you can set this
# value smaller.
# After connected to multiple hosts, in a window, you can use 
# `synchronize-panes` feature of Tmux, which can duplicate input
# to any pane to all other panes in the same window
# ------------------------------------------------------------------

tmux='tmux -2'

HOSTS_FILE=$1
if [ -z "$HOSTS_FILE" ]; then
    echo "[ERROR] usage: $0 <HOSTS_FILE>"
    exit 1
fi

# remove empty lines and comment lines
HOSTS=$(sed -e 's/#.*$//' -e '/^$/d' $HOSTS_FILE)

WINDOW_NAME=tmux-multi
MAX_PANES=16  # max panes per window
HOSTS_COUNT=$(echo "$HOSTS" | wc -l)
PANE_BASE_INDEX=$(tmux show -gv pane-base-index)

widx=0  # window index
hidx=0  # host index
declare -i selected_pane

while read host; do

    # every MAX_PANES number of hosts put in one window
    if [ $(( hidx % 16 )) -eq 0 ]; then
        (( widx++ ))
        selected_pane=${PANE_BASE_INDEX:-1}
        tmux new-window -n "$WINDOW_NAME-$widx"
        tmux select-window -t "$WINDOW_NAME-$widx"
    fi

    (( hidx++ ))

    # The C-m at the end is interpreted by Tmux as the enter key.
    tmux send-keys -t $selected_pane "ssh root@$host" C-m

    if [ $selected_pane -lt $MAX_PANES -a $hidx -lt $HOSTS_COUNT ]; then
        tmux split-window -h
    else
        # last pane of a window, enable sync
        tmux set-window-option synchronize-panes on
    fi

    (( selected_pane++ ))

    tmux select-layout tiled

done < <(echo "$HOSTS")
