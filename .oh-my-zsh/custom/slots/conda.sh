CONDA_ENV=$HOME/.conda/envs
CONDA_DOTFILES=$HOME/.conda/envs/dotfiles
CONDA_DOTFILES_PYTHON=$HOME/.conda/envs/dotfiles/bin/python

function setconda() {
    if [ -d "$CONDA_ENV/$1" ]; then
        export PATH="$CONDA_ENV/$1/bin:$PATH"
    fi
}

setconda "dotfiles"
