omz_post_add_user_env_paths() {
    local paths=(
        "${HOME}/.local/bin"
    )
    add_env_paths "${paths[@]}"
}

omz_post_load() {
    omz_post_add_user_env_paths
}

omz_post_load

# unfunction ${(k)functions[(I)omz_post_*]}
