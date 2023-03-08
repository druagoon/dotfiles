__init_hatch() {
    if [[ -x "$(command -v hatch)" ]]; then
        . "$ZSH_CUSTOM_COMPLETIONS/hatch-completion.zsh"
    fi
}

__init_hatch
