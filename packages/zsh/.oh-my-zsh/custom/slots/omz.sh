__init_omz_plugin() {
    declare -a plugins=(
        zsh-autosuggestions https://github.com/zsh-users/zsh-autosuggestions
        zsh-syntax-highlighting https://github.com/zsh-users/zsh-syntax-highlighting.git
    )

    for i in {1..${#plugins[@]}..2}; do
        local name="${plugins[${i}]}"
        local repo="${plugins[${i} + 1]}"
        local plugin_dir="${ZSH_CUSTOM_PLUGINS}/${name}"
        if [[ ! -d "${plugin_dir}" ]]; then
            echo "Install plugin \"${name}\" from \"${repo}\""
            git clone "${repo}" "${plugin_dir}" && echo
        fi
    done
}

__init_omz() {
    __init_omz_plugin
}

__init_omz
