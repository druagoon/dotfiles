#!/bin/bash

arch="$(uname -m)"
if [[ "${arch}" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
export PATH="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${PATH}"

STOW_SRC="${HOME}/.dotfiles"
STOW_TARGET="${HOME}"

do_stow() {
    stow -v -d "${STOW_SRC}" -t "${STOW_TARGET}" "${1}"
}

link_brew() {
    do_stow brew
}

link_go() {
    do_stow go
}

link_conda() {
    do_stow conda
}

link_zsh() {
    local zfiles=(.zprofile .zshenv .zshrc)
    for v in "${zfiles[@]}"; do
        local filepath="${HOME}/${v}"
        if [[ ! -L "${filepath}" ]]; then
            rm -f "${filepath}"
            echo "Delete ${filepath}"
        fi
    done
    do_stow zsh
}

link_python() {
    do_stow python
}

main() {
    link_brew
    link_go
    link_conda
    link_zsh
    link_python
}

main
