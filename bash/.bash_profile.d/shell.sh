BLACK="\033[0;30m"
RED="\033[0;31m"
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
LIGHT_GRAY="\033[0;37m"
RESET="\033[0m"

_get_branch_name() {
    name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -z "${name}" ]]; then
        echo ""
    else
        echo -e "${BLUE}(${ORANGE}${name}${BLUE})${RESET}"
    fi
}

ldprofile() {
    source ~/.bash_profile
}

ldps1() {
    export PS1="${RESET}[${RED}\D{%Y/%m/%d} \t ${GREEN}\w${RESET}\$(_get_branch_name)${RESET}]\n[${PURPLE}\u${BLUE}@${CYAN}\H${RESET}]\$ "
}

ldpps1() {
    export PS1="${RESET}[${RED}\D{%Y/%m/%d} \t ${GREEN}\w${RESET}]\n[${PURPLE}\u${BLUE}@${CYAN}\H${RESET}]\$ "
}

_init_shell_path() {
    paths=("${HOME}/bin" "${HOME}/.local/bin" /usr/local/sbin /usr/local/bin)
    for v in "${paths[@]}"; do
        if [[ ":${PATH}:" != *":${v}:"* ]]; then
            export PATH="${v}:${PATH}"
        fi
    done
}

_init_shell() {
    _init_shell_path
}

_init_shell
