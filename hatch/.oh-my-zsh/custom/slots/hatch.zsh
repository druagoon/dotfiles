_init_hatch() {
    if [[ -x "$(command -v hatch)" ]]; then
        . "$ZSH_CUSTOM_COMPLETIONS/hatch-completion.zsh"
    fi
}

_init_hatch
