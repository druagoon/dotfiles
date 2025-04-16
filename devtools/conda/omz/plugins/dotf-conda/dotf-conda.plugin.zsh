CONDA_ENVS_DIR="${HOME}/.conda/envs"

set_conda_env_path() {
    local path="$CONDA_ENVS_DIR/$1"
    if [[ -d "${path}" ]]; then
        _dotf::env::path::prepend "${path}/bin"
    fi
}
