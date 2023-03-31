# https://en.wikipedia.org/wiki/ANSI_escape_code

alias la='ls -lAh --color=auto'
alias ll='ls -lh --color=auto'
alias lsa='ls -lah --color=auto'

BLACK="\033[0;30m"
RED="\033[0;31m"
RED_B="\033[1;31m"
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
LIGHT_GRAY="\033[0;37m"
LIGHT_GRAY_I="\033[3;37m"
RESET="\033[0m"

showcolor() {
    echo -e "${BLACK} BLACK ${RESET}"
    echo -e "${RED} RED ${RESET}"
    echo -e "${GREEN} GREEN ${RESET}"
    echo -e "${ORANGE} ORANGE ${RESET}"
    echo -e "${BLUE} BLUE ${RESET}"
    echo -e "${PURPLE} PURPLE ${RESET}"
    echo -e "${CYAN} CYAN ${RESET}"
    echo -e "${LIGHT_GRAY} LIGHT_GRAY ${RESET}"
}

__get_ip() {
    ip=""
    if [[ -x "$(command -v ip)" ]]; then
        ip=$(ip -o -4 addr list | grep -v "127.0.0.1" | awk '{ip=$2"="$4; print ip}' | cut -d/ -f1 | xargs)
    fi
    echo "$ip"
}

__get_branch_name() {
    name="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [[ -z "${name}" ]]; then
        echo ""
    else
        echo -e "${GREEN}(${RED_B}${name}${GREEN})"
    fi
}

ldprofile() {
    source ~/.bash_profile
}

__ps_part() {
    echo "${RESET}$1${RESET}"
}

ldps1() {
    time="$(__ps_part "${BLUE}\\D{%Y/%m/%d} \\t")"
    ip="$(__ps_part "${ORANGE}$(__get_ip)")"
    cwd="$(__ps_part "${LIGHT_GRAY_I}\\w")"
    branch="$(__ps_part "\$(__get_branch_name)")"
    user="$(__ps_part "${PURPLE}\\u")"
    host="$(__ps_part "${CYAN}\\H")"
    export PS1="[${time} ${ip} ${cwd} ${branch}]\n[${user}@${host}]\$ "
    # export PS1="${RESET}[${BLUE}\D{%Y/%m/%d} \t ${ORANGE}$(__get_ip) ${GREEN}\w${RESET}\$(__get_branch_name)${RESET}]\n[${PURPLE}\u${BLUE}@${CYAN}\H${RESET}]\$ "
}

__init_shell_path() {
    paths=("${HOME}/bin" "${HOME}/.local/bin" /usr/local/sbin /usr/local/bin)
    for v in "${paths[@]}"; do
        if [[ ":${PATH}:" != *":${v}:"* ]]; then
            export PATH="${v}:${PATH}"
        fi
    done
}

__init_shell() {
    __init_shell_path
}

__init_shell
