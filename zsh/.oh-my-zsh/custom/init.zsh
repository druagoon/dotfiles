# Zsh custom directory
export ZSH_CUSTOM_SLOTS="${ZSH_CUSTOM}/slots"
export ZSH_CUSTOM_UTILS="${ZSH_CUSTOM}/utils"
export ZSH_CUSTOM_INITD="${ZSH_CUSTOM}/init.d"
export ZSH_CUSTOM_COMPLETIONS="${ZSH_CUSTOM}/completions"

# Dotfiles root directory
export DF_NAME="dotfiles"
export DF_X_NAME=".dotfiles"
export DF_ROOT="${HOME}/${DF_X_NAME}"

__load_utils() {
    for v in "${ZSH_CUSTOM_UTILS}"/*.sh; do
        . "$v"
    done
}

__load_slots() {
    for slot in "${ZSH_CUSTOM_SLOTS}"/*.sh; do
        . "$slot"
    done
}

__load_preposition() {
    preposition=(shell.sh proxy.sh brew.sh conda.sh venv.sh go.sh)
    for v in "${preposition[@]}"; do
        if [[ -f "$ZSH_CUSTOM_INITD/$v" ]]; then
            . "$ZSH_CUSTOM_INITD/$v"
        fi
    done
}

__init_zsh() {
    __load_utils
    __load_preposition
    __load_slots
}

__init_zsh
