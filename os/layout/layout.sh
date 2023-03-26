#/bin/bash

LAYOUT_DIR="${HOME}/.dotfiles/os/layout"

layout_git() {
    local filename="$(basename "$1")"
    local filepath="${LAYOUT_DIR}/${filename}.txt"

    # Clear layout file content
    >"${filepath}"

    find "$1" -name ".git" ! -path '*/.local/*' | while read name; do
        local target=$(dirname "${name}")
        local url="$(git -C "${target}" config --get remote.origin.url)"
        local path="~${target#${HOME}}"
        echo "${path} ${url}" >>"${filepath}"
    done
}

layout_git "$1"
