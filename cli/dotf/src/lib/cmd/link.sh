dotf::link::stow_log() {
    if [[ $? -eq 0 ]]; then
        local result="$(green_bold OK)"
    else
        local result="$(red_bold ERROR)"
    fi
    printf "stow %-12s [ %s ]\n" "$1" "${result}"
}

dotf::link::stow_make() {
    local flags=()
    if dotf::utils::boolean::is_true ${args[--delete]}; then
        flags+=("-D")
    fi
    if dotf::utils::boolean::is_true ${args[--restow]}; then
        flags+=("-R")
    fi
    if dotf::utils::boolean::is_true ${args[--adopt]}; then
        flags+=("--adopt")
    fi
    if dotf::utils::boolean::is_true ${args[--simulate]}; then
        flags+=("-n")
    fi
    if dotf::utils::boolean::is_true ${args[--verbose]}; then
        flags+=("-v")
    fi
    local opt=$(
        IFS=" "
        echo "${flags[*]}"
    )
    stow ${opt} -d "${DOTF_LINK_STOW_SRC}" -t "${DOTF_LINK_STOW_TARGET}" "$1"
}

dotf::link::pkg_is_exclude() {
    [[ ":${DOTF_LINK_EXCLUDE_PACKAGES_STRING}:" == *":$1:"* ]]
}

dotf::link::pkg_stow() {
    dotf::link::stow_make stow
}

dotf::link::pkg_brew() {
    dotf::link::stow_make brew
}

dotf::link::pkg_go() {
    dotf::link::stow_make go
}

dotf::link::pkg_conda() {
    dotf::link::stow_make conda
}

dotf::link::pkg_zsh() {
    # local zfiles=(.zprofile .zshenv .zshrc)
    # for v in "${zfiles[@]}"; do
    #     local filepath="${HOME}/${v}"
    #     if [[ ! -L "${filepath}" ]]; then
    #         rm -f "${filepath}"
    #         echo "Delete ${filepath}"
    #     fi
    # done
    dotf::link::stow_make zsh
}

dotf::link::pkg_python() {
    dotf::link::stow_make python
}

dotf::link::pkg_deps() {
    dotf::link::pkg_stow
    dotf::link::pkg_brew
    dotf::link::pkg_go
    dotf::link::pkg_conda
    dotf::link::pkg_zsh
    dotf::link::pkg_python
}

dotf::link::packages() {
    find "${DOTF_LINK_STOW_SRC}" -maxdepth 1 -mindepth 1 -type d | sort | while read name; do
        local pkg=$(basename "${name}")
        if ! dotf::link::pkg_is_exclude "${pkg}"; then
            dotf::link::stow_make "${pkg}"
            dotf::link::stow_log "${pkg}"
        fi
    done
}
