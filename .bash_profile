# Get the aliases and functions
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs
alias gst="git status"
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias gd="git diff --color"
alias gb="git branch"
alias gco="git checkout"

BLACK='\033[0;30m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT_GRAY='\033[0;37m'
RESET='\033[0m'

function get_branch_name() {
    name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
    if [[ -z "${name}" ]]; then
        echo ""
    else
        echo -e "${BLUE}(${ORANGE}${name}${BLUE})${RESET}"
    fi
}

alias ldsh="source ~/.bash_profile"
alias ldpps1="export PS1=\"${RESET}[${RED}\D{%Y/%m/%d} \t ${GREEN}\w${RESET}]\n[${PURPLE}\u${BLUE}@${CYAN}\H${RESET}]\\$ \""
alias ldps1="export PS1=\"${RESET}[${RED}\D{%Y/%m/%d} \t ${GREEN}\w${RESET}\\\$(get_branch_name)${RESET}]\n[${PURPLE}\u${BLUE}@${CYAN}\H${RESET}]\\$ \""

[[ -f "/etc/bash_completion.d/git" ]] && . "/etc/bash_completion.d/git"

PATH=$PATH:$HOME/.local/bin:$HOME/bin

export PATH
