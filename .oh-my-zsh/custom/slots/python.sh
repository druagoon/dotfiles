# Python
alias py27="~/.conda/envs/py27/bin/python"
alias pip27="~/.conda/envs/py27/bin/pip"
alias ipy27="~/.conda/envs/py27/bin/ipython"

function ldvenv() {
    key=$(basename "$(pwd)")
    VENV_DIRS=("venv" ".venv" "$HOME/.virtualenvs" "$HOME/.conda/envs")
    for v in "${VENV_DIRS[@]}"; do
        if [[ -f "$v/bin/activate" ]]; then
            . "$v/bin/activate"
            break
        fi
        if [[ -f "$v/$key/bin/activate" ]]; then
            . "$v/$key/bin/activate"
            break
        fi
    done
}
