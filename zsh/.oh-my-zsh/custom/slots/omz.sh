__init_omz_plugin() {
    declare -A plugins=(
        ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
        ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    )

    # Only working in zsh
    for key val in "${(@kv)plugins}"; do
        local plugin="${ZSH_CUSTOM_PLUGINS}/${key}"
        if [[ ! -d "${plugin}" ]]; then
            echo "Install plugin \"${key}\" from \"${val}\""
            git clone "${val}" "${plugin}" && echo
        fi
    done
}

__init_omz() {
    __init_omz_plugin
}

__init_omz
