__dotf_python_venv_init() {
    local root="${DOTFILES_ROOT}"
    local venv_dir="${root}/.venv"
    local venv_bin_dir="${venv_dir}/bin"
    local venv_python_version="$(head -n 1 "${root}/.python-version")"

    if [[ ! -d "${venv_dir}" ]]; then
        if ! uv python find "${venv_python_version}" >/dev/null 2>&1; then
            uv python install "${venv_python_version}"
        fi
        echo "Creating dotfiles venv at: ${venv_dir}"
        uv venv --python "${venv_python_version}" "${venv_dir}"
    fi

    _dotf::env::path::prepend "${venv_bin_dir}"
}

__dotf_python_venv_init
