__init_pyenv_completion() {
    if _dotf::cmd::check pyenv; then
        local pyenv_prefix="$(brew --prefix pyenv 2>/dev/null)"
        if [[ -n "${pyenv_prefix}" ]]; then
            . "${pyenv_prefix}/completions/pyenv.zsh"
        fi
    fi
}

__init_pyenv_completion
