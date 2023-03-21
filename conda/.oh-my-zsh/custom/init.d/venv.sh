DF_VENV_NAME=".venv"
DF_VENV="${DF_ROOT}/${DF_VENV_NAME}"
DF_VENV_BIN="${DF_VENV}/bin"
DF_VENV_PYTHON="${DF_VENV_BIN}/python"
DF_VENV_PIP="${DF_VENV_BIN}/pip"
DF_VENV_ICLI="${DF_VENV_BIN}/icli"

_setup_venv() {
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

_install_venv_icli() {
    if [[ ! -x "${DF_VENV_ICLI}" ]]; then
        echo "Install ... icli"
        "${DF_VENV_PIP}" install git+ssh://git@github.com/druagoon/icli-python.git@master
    fi
}

__init_venv_path() {
    df_prepend_path "${DF_VENV_BIN}"
}

__init_venv() {
    _setup_venv
    _install_venv_icli
    __init_venv_path
}

__init_venv
