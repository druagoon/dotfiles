if command -v pipx &>/dev/null; then
    if ! command -v register-python-argcomplete &>/dev/null; then
        pipx install argcomplete
    fi
    eval "$(register-python-argcomplete pipx)"
fi
