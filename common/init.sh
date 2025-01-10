# shellcheck shell=bash
# shellcheck source=/dev/null

PROGPATH=$(realpath "${BASH_SOURCE[0]:-${(%):-%x}}")  # bash && zsh
COMMDIR=$(dirname "${PROGPATH}")

source "${COMMDIR}/exports.sh"
source "${COMMDIR}/aliases.sh"
source "${COMMDIR}/functions.sh"
source "${COMMDIR}/python.sh"
source "${COMMDIR}/golang.sh"
#source "${COMMDIR}/quickjump.sh"
source "${COMMDIR}/ssh-agent-wrapper.sh"
source "${COMMDIR}/other.sh"

if [[ "$(uname)" == "Darwin" ]]; then
    source "${COMMDIR}/darwin.sh"
fi

# compat with bash/zsh
if [ -d "${HOME}/.custom" ]; then
    custom_sh=( $( find "${HOME}/.custom" -name '*.sh' ) )
    if [ ${#custom_sh[@]} -gt 0 ]; then
        for sf in "${custom_sh[@]}"; do
            source "$sf"
        done
    fi
fi

