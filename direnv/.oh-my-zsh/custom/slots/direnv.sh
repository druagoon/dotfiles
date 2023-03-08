__init_direnv() {
    if [[ -x "$(command -v direnv)" ]]; then
        eval "$(direnv hook zsh)"
    fi
}

__init_direnv
