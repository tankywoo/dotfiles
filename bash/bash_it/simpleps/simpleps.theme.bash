# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

# use true color under mosh ssh

function prompt_command() {
	PS1="${green?}>${bold_blue?}${reset_color?} ${normal?}"
}

safe_append_prompt_command prompt_command
