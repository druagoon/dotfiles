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

EXCLUDE_SLOTS=(.git .venv .vscode bin)
EXCLUDE_SLOTS_STRING=$(
    IFS=:
    echo "${EXCLUDE_SLOTS[*]}"
)

stow_log() {
    echo -e "stow ... $1"
}

do_stow() {
    stow -v --adopt -d "${STOW_SRC}" -t "${STOW_TARGET}" "$1"
}

is_exclude_slot() {
    local ret="0"
    if [[ ":${EXCLUDE_SLOTS_STRING}:" == *":$1:"* ]]; then
        ret="1"
    fi
    echo "${ret}"
}

link_deps() {
    link_stow
    link_brew
    link_go
    link_conda
    link_zsh
    link_python
}

link_stow() {
    do_stow stow
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

link_slots() {
    find "${STOW_SRC}" -depth 1 -type d | while read name; do
        local slot=$(basename "${name}")
        local ret=$(is_exclude_slot "${slot}")
        if [[ "${ret}" == 0 ]]; then
            stow_log "${slot}"
            do_stow "${slot}"
        fi
    done
}

main() {
    link_deps
    link_slots
}

main
