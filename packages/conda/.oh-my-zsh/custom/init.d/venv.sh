# DOTF_VENV_NAME=".venv"
# DOTF_VENV="${DOTFILES_ROOT}/${DOTF_VENV_NAME}"
# DOTF_VENV_BIN="${DOTF_VENV}/bin"
# DOTF_VENV_PYTHON="${DOTF_VENV_BIN}/python"
# DOTF_VENV_PIP="${DOTF_VENV_BIN}/pip"
# DOTF_VENV_ICLI="${DOTF_VENV_BIN}/icli"

# _setup_venv() {
#     if [[ ! -d "${DOTF_VENV}" ]]; then
#         if [[ -f "${DOTF_VENV_EXTERNAL_PYTHON}" ]]; then
#             echo "Creating venv in: ${DOTF_VENV}"
#             "${DOTF_VENV_EXTERNAL_PYTHON}" -m venv --copies "${DOTF_VENV}"
#         else
#             echo "${DOTF_VENV_EXTERNAL_PYTHON} not found."
#             exit 1
#         fi
#     fi
# }

# _install_venv_icli() {
#     if [[ ! -x "${DOTF_VENV_ICLI}" ]]; then
#         local repo="git+ssh://git@github.com/druagoon/icli-python.git@master"
#         echo "Pip install \"icli\" from: ${repo}"
#         "${DOTF_VENV_PIP}" install "${repo}"
#     fi
# }

# __init_venv_path() {
#     _dotf::cmd::path::prepend "${DOTF_VENV_BIN}"
# }

# __init_venv() {
#     _setup_venv
#     # _install_venv_icli
#     __init_venv_path
# }

# __init_venv
