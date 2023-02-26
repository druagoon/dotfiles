CONDA_ENV="${HOME}/.conda/envs"
CONDA_DOTFILES="${HOME}/.conda/envs/dotfiles"
CONDA_DOTFILES_PYTHON="${HOME}/.conda/envs/dotfiles/bin/python"

setconda() {
    if [[ -d "$CONDA_ENV/$1" ]]; then
        prepend_path "$CONDA_ENV/$1/bin"
    fi
}

_init_conda() {
    setconda "dotfiles"
}

_init_conda
