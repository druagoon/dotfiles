__init_direnv() {
    if _dotf::cmd::check direnv; then
        eval "$(direnv hook zsh)"
    fi
}

__init_direnv
