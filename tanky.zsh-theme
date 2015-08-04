# changed from philips.zsh-theme

if [ $UID -eq 0 ]; then NCOLOR="red"; else NCOLOR="blue"; fi

PS1_PRE=''
PS1_BOLD_PRE="false"
if [ -n "${PS1_ENABLE_USERNAME}" ] && [ "${PS1_ENABLE_USERNAME}" = true ]; then
    PS1_PRE=${PS1_PRE}'%n'
fi
if [ -n "${PS1_ENABLE_HOSTNAME}" ] && [ "${PS1_ENABLE_HOSTNAME}" = true ]; then
    PS1_PRE=${PS1_PRE}'@%m'
fi
if [ -n "${PS1_BOLD_PRE}" ] && [ "${PS1_BOLD_PRE}" = true ]; then
    PS1_PRE='%B'${PS1_PRE}'%b'
fi
if [ -n "${PS1_PRE}" ]; then
    PS1_PRE=${PS1_PRE}' '   # add a space between username and path
fi

# use $FG, not $fg, for 256 color
PROMPT='%{$fg[$NCOLOR]%}'${PS1_PRE}'%{$reset_color%}%{$fg[cyan]%}%~%{$reset_color%} $(git_prompt_info)%{$fg[blue]%}%%%{$reset_color%} '


# git theming
ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg_no_bold[yellow]%}%B"
ZSH_THEME_GIT_PROMPT_SUFFIX="%b%{$fg_bold[blue]%})%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg_bold[red]%}*"

# LS colors, made with http://geoff.greer.fm/lscolors/
export LSCOLORS="Gxfxcxdxbxegedabagacad"
export LS_COLORS='no=00:fi=00:di=01;34:ln=00;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=41;33;01:ex=00;32:*.dll=01;32:*.tar=00;31:*.tbz=00;31:*.tgz=00;31:*.rpm=00;31:*.deb=00;31:*.zip=00;31:*.z=00;31:*.Z=00;31:*.gz=00;31:*.bz2=00;31:*.bmp=01;35:*.gif=01;35:*.jpg=01;35:*.jpeg=01;35:*.png=01;35:'

# custom
export LS_COLORS="${LS_COLORS}*.md=00;33:*.py=00;35:*.pyc=00;37:*.rb=00;36:"
