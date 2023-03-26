CONDA_ENVS_DIR="${HOME}/.conda/envs"
CONDA_DF_VENV="${CONDA_ENVS_DIR}/${DOTFILES_NAME}"
CONDA_DF_VENV_BIN="${CONDA_DF_VENV}/bin"
CONDA_DF_VENV_PYTHON="${CONDA_DF_VENV_BIN}/python"

setcondaenv() {
    if [[ -d "$CONDA_ENVS_DIR/$1" ]]; then
        df_prepend_path "$CONDA_ENVS_DIR/$1/bin"
    fi
}

__init_conda_dotfiles_env() {
    if [[ ! -d "${CONDA_DF_VENV}" ]]; then
        echo "Creating conda python(${CONDA_DF_PYTHON_VERSION}) in: ${CONDA_DF_VENV}"
        conda create -n "${DOTFILES_NAME}" python="${CONDA_DF_PYTHON_VERSION}"
    fi
}

__init_conda() {
    __init_conda_dotfiles_env
}

__init_conda
