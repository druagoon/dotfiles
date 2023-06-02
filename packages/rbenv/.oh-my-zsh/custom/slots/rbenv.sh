__init_rbenv_shell() {
    if _dotf::cmd::check rbenv; then
        eval "$(rbenv init - zsh)"
    fi
}

__init_rbenv() {
    __init_rbenv_shell
}

__init_rbenv
