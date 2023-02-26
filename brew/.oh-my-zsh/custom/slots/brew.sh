alias bs="brew search"
alias bi="brew info"
alias bic="brew info --cask"
alias blc="brew list --cask"
alias bocg="brew outdated --cask --greedy"

_init_brew_path() {
    arch="$(uname -m)"
    if [[ "${arch}" == "arm64" ]]; then
        brew_prefix="/opt/homebrew"
    else
        brew_prefix="/usr/local"
    fi

    prepend_path "${brew_prefix}/sbin"
    prepend_path "${brew_prefix}/bin"
}

_init_brew() {
    _init_brew_path
}

_init_brew
