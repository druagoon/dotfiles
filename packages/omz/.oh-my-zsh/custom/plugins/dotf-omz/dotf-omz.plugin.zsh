__dotf_omz_install_plugins() {
    local -a plugins=(
        https://github.com/zsh-users/zsh-autosuggestions
        https://github.com/zsh-users/zsh-syntax-highlighting
    )

    for url in "${plugins[@]}"; do
        local name="${url##*/}"
        local plugin_dir="${ZSH_CUSTOM_PLUGINS}/${name}"
        if [[ ! -d "${plugin_dir}" ]]; then
            echo "Install plugin \"${name}\" from \"${url}\""
            git clone "${url}" "${plugin_dir}" && echo
        fi
    done
}

__dotf_omz_init() {
    __dotf_omz_install_plugins
}

__dotf_omz_init
