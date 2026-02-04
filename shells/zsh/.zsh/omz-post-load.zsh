omz_post_load_bashcompinit() {
    # Autoload in https://github.com/ohmyzsh/ohmyzsh/blob/master/lib/completion.zsh
    autoload -Uz +X bashcompinit && bashcompinit
}

omz_post_add_user_env_paths() {
    local paths=(
        "${HOME}/.local/bin"
    )
    add_env_paths "${paths[@]}"
}

omz_post_load() {
    # omz_post_load_bashcompinit
    omz_post_add_user_env_paths
}

omz_post_load

# unfunction ${(k)functions[(I)omz_post_*]}
