_init_direnv() {
    if [[ -x "$(command -v direnv)" ]]; then
        eval "$(direnv hook zsh)"
    fi
}

_init_direnv
