ldvenv() {
    local activate=""
    local inner_dirs=(.venv venv)
    for v in "${inner_dirs[@]}"; do
        activate="${v}/bin/activate"
        if [[ -f "${activate}" ]]; then
            . "${activate}"
            break
        fi
    done

    local key="$(basename "$(pwd)")"
    local outer_dirs=("${HOME}/.virtualenvs" "${HOME}/.conda/envs")
    for v in "${outer_dirs[@]}"; do
        activate="${v}/${key}/bin/activate"
        if [[ -f "${activate}" ]]; then
            . "${activate}"
            break
        fi
    done
}
