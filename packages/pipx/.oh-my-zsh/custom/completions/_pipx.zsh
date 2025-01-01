if _dotf::cmd::check pipx; then
    if ! _dotf::cmd::check register-python-argcomplete; then
        brew install python-argcomplete
    fi
    eval "$(register-python-argcomplete pipx)"
fi
