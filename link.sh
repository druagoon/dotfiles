#!/bin/bash

DOTFILES_ROOT="${HOME}/.dotfiles"
STOW_SRC="${DOTFILES_ROOT}/packages"
STOW_TARGET="${HOME}"

EXCLUDE_PACKAGES=(.git .venv .vscode)
EXCLUDE_PACKAGES_STRING=$(
    IFS=:
    echo "${EXCLUDE_PACKAGES[*]}"
)

stow_log() {
    printf "stow %-12s ... done\n" "$1"
}

do_stow() {
    stow -v --adopt -d "${STOW_SRC}" -t "${STOW_TARGET}" "$1"
}

is_exclude_pkg() {
    if [[ ":${EXCLUDE_PACKAGES_STRING}:" == *":$1:"* ]]; then
        return
    fi
    false
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
    # local zfiles=(.zprofile .zshenv .zshrc)
    # for v in "${zfiles[@]}"; do
    #     local filepath="${HOME}/${v}"
    #     if [[ ! -L "${filepath}" ]]; then
    #         rm -f "${filepath}"
    #         echo "Delete ${filepath}"
    #     fi
    # done
    do_stow zsh
}

link_python() {
    do_stow python
}

link_packages() {
    find "${STOW_SRC}" -maxdepth 1 -mindepth 1 -type d | sort | while read name; do
        local pkg=$(basename "${name}")
        if ! is_exclude_pkg "${pkg}"; then
            do_stow "${pkg}"
            stow_log "${pkg}"
        fi
    done
}

get_brew_prefix() {
    local prefix=""
    arch="$(uname -m)"
    if [[ "${arch}" == "arm64" ]]; then
        prefix="/opt/homebrew"
    else
        prefix="/usr/local"
    fi
    echo "${prefix}"
}

init_brew_env() {
    local brew_prefix="$(get_brew_prefix)"
    if [[ -n "${brew_prefix}" ]]; then
        eval "$("${brew_prefix}"/bin/brew shellenv)" || exit 1
    fi
}

init() {
    init_brew_env
}

main() {
    init
    link_deps
    link_packages
}

main
