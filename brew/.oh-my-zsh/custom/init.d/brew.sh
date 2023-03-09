alias bs="brew search"
alias bi="brew info"
alias bic="brew info --cask"
alias blc="brew list --cask"
alias bocg="brew outdated --cask --greedy"


__init_brew_path() {
    arch="$(uname -m)"
    if [[ "${arch}" == "arm64" ]]; then
        local brew_prefix="/opt/homebrew"
    else
        local brew_prefix="/usr/local"
    fi

    df_prepend_path "${brew_prefix}/sbin"
    df_prepend_path "${brew_prefix}/bin"
}

__init_brew() {
    __init_brew_path
}

__init_brew
