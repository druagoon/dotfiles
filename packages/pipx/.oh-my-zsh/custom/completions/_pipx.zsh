autoload -U +X bashcompinit && bashcompinit

if command -v pipx &>/dev/null; then
    eval "$(register-python-argcomplete pipx)"
fi
