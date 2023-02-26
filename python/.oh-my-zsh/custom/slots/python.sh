ldvenv() {
    key=$(basename "$(pwd)")
    venv_dirs=("venv" ".venv" "${HOME}/.virtualenvs" "${HOME}/.conda/envs")
    for v in "${venv_dirs[@]}"; do
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
