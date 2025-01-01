DOTF_VENV_NAME=".venv"
DOTF_VENV_DIR="${DOTFILES_ROOT}/${DOTF_VENV_NAME}"
DOTF_VENV_BIN="${DOTF_VENV_DIR}/bin"
DOTF_VENV_PYTHON_VERSION="$(head -n 1 "${DOTFILES_ROOT}/.python-version")"

_setup_venv() {
    if [[ ! -d "${DOTF_VENV_DIR}" ]]; then
        if ! uv python find "${DOTF_VENV_PYTHON_VERSION}" >/dev/null 2>&1; then
            uv python install "${DOTF_VENV_PYTHON_VERSION}"
        fi
        echo "Creating dotfiles venv at: ${DOTF_VENV_DIR}"
        uv venv --python "${DOTF_VENV_PYTHON_VERSION}" "${DOTF_VENV_DIR}"
    fi
}

__init_venv_path() {
    _dotf::cmd::path::prepend "${DOTF_VENV_BIN}"
}

__init_venv() {
    _setup_venv
    __init_venv_path
}

__init_venv
