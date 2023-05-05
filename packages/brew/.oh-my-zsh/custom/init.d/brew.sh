alias bs="brew search"
alias bi="brew info"
alias bic="brew info --cask"
alias blc="brew list --cask"
alias bocg="brew outdated --cask --greedy"

__get_brew_prefix() {
    local prefix=""
    arch="$(uname -m)"
    if [[ "${arch}" == "arm64" ]]; then
        prefix="/opt/homebrew"
    else
        prefix="/usr/local"
    fi
    echo "${prefix}"
}

__init_brew_path() {
    local brew_prefix="$(__get_brew_prefix)"
    if [[ -n "${brew_prefix}" ]]; then
        eval "$("${brew_prefix}"/bin/brew shellenv)"
        dotf::cmd::path::prepend "${brew_prefix}/sbin"
        dotf::cmd::path::prepend "${brew_prefix}/bin"
    fi
}

__init_brew() {
    __init_brew_path
}

__init_brew
