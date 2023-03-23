# Zsh custom directory
export ZSH_CUSTOM_SLOTS="${ZSH_CUSTOM}/slots"
export ZSH_CUSTOM_UTILS="${ZSH_CUSTOM}/utils"
export ZSH_CUSTOM_INITD="${ZSH_CUSTOM}/init.d"
export ZSH_CUSTOM_PLUGINS="${ZSH_CUSTOM}/plugins"
export ZSH_CUSTOM_COMPLETIONS="${ZSH_CUSTOM}/completions"

# Dotfiles root directory
export DF_NAME="dotfiles"
export DF_DOT_NAME=".dotfiles"
export DF_ROOT="${HOME}/${DF_DOT_NAME}"

__load_utils() {
    for v in "${ZSH_CUSTOM_UTILS}"/*.sh; do
        . "${v}"
    done
}

__load_preposition() {
    preposition=(shell.sh proxy.sh brew.sh conda.sh venv.sh go.sh)
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
