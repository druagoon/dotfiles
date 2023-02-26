_init_pip() {
    if [[ -x "$(command -v pip)" ]]; then
        . $ZSH_CUSTOM_COMPLETIONS/pip-completion.zsh
    fi
}

_init_pip
