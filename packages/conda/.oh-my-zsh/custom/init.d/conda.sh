CONDA_ENVS_DIR="${HOME}/.conda/envs"
CONDA_DOTF_VENV="${CONDA_ENVS_DIR}/${DOTFILES_NAME}"
CONDA_DOTF_VENV_BIN="${CONDA_DOTF_VENV}/bin"
CONDA_DOTF_VENV_PYTHON_VERSION="3.10"
# Dotfiles external python interpreter
DOTF_VENV_EXTERNAL_PYTHON="${CONDA_DOTF_VENV_BIN}/python"

setcondaenv() {
    if [[ -d "$CONDA_ENVS_DIR/$1" ]]; then
        dotf::cmd::path::prepend "$CONDA_ENVS_DIR/$1/bin"
    fi
}

__init_conda_dotfiles_env() {
    if [[ ! -d "${CONDA_DOTF_VENV}" ]]; then
        echo "Creating conda python(${CONDA_DOTF_VENV_PYTHON_VERSION}) in: ${CONDA_DOTF_VENV}"
        conda create -n "${DOTFILES_NAME}" python="${CONDA_DOTF_VENV_PYTHON_VERSION}"
    fi
}

__init_conda() {
    __init_conda_dotfiles_env
}

__init_conda
