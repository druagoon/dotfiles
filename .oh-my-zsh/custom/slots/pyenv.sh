export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
if [ -x "$PYENV_ROOT/bin/pyenv" ]; then
    eval "$(pyenv init -)"
fi
