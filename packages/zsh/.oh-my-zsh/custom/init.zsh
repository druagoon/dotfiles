__load_utils() {
    for v in "${ZSH_CUSTOM_UTILS}"/*.sh; do
        . "${v}"
    done
}

__load_preposition() {
    local preposition=(
        shell.sh
        proxy.sh
        brew.sh
        go.sh
        rust.sh
        venv.sh
    )
    for v in "${preposition[@]}"; do
        local filepath="${ZSH_CUSTOM_INITD}/${v}"
        if [[ -f "${filepath}" ]]; then
            . "${filepath}"
        fi
    done
}

__load_slots() {
    for slot in "${ZSH_CUSTOM_SLOTS}"/*.sh; do
        . "${slot}"
    done
}

__load_completions() {
    for f in "${ZSH_CUSTOM_COMPLETIONS}"/*.zsh; do
        . "${f}"
    done
}

__init_zsh() {
    __load_utils
    __load_preposition
    __load_slots
    __load_completions
}

__init_zsh
