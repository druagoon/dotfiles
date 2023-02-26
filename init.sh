. ./vars.sh

init_conda() {
    if [[ ! -d "${CONDA_DF_VENV}" ]]; then
        echo "Creating conda python(${CONDA_DF_PYTHON_VERSION}) in: ${CONDA_DF_VENV}"
        conda create -n dotfiles python="${CONDA_DF_PYTHON_VERSION}"
    fi
}

init_venv() {
    if [[ ! -d "${DF_VENV}" ]]; then
        if [[ -f "${CONDA_DF_VENV_PYTHON}" ]]; then
            echo "Creating venv in: ${DF_VENV}"
            "${CONDA_DF_VENV_PYTHON}" -m venv --copies "${DF_VENV}"
        else
            echo "${CONDA_DF_VENV_PYTHON} not found."
            exit 1
        fi
    fi
}

init() {
    init_conda && init_venv
}

init
