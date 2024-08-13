# @cmd Create symbolic links for dotfiles packages
#
# Examples:
#   dotf link -- -v
#   dotf link -- -v -n
#   dotf link -- -v -n --adopt
#
# @meta require-tools stow
# @arg stow*        capture all remaining options for stow
link() {
    dotf_link_make_deps
    dotf_link_make_pkgs
}

dotf_link_stow_log() {
    local result
    if [[ $? -eq 0 ]]; then
        result="$(std::color::green_bold OK)"
    else
        result="$(std::color::red_bold ERROR)"
    fi
    printf "%-12s [ %s ]\n" "$1" "${result}"
}

dotf_link_stow() {
    local opt=$(
        IFS=" "
        echo "${argc_stow[*]}"
    )
    stow ${opt} -d "${DOTF_LINK_STOW_SRC}" -t "${DOTF_LINK_STOW_TARGET}" "$@"
}

dotf_link_pkg_is_exclude() {
    [[ ":${DOTF_LINK_EXCLUDE_PKG_STRING}:" == *":$1:"* ]]
}

dotf_link_make_deps() {
    local deps=(
        stow
        zsh
        brew
        rust
        go
        conda
        python
    )
    for v in "${deps[@]}"; do
        dotf_link_stow "$v"
        dotf_link_stow_log "$v"
    done
}

dotf_link_make_pkgs() {
    find "${DOTF_LINK_STOW_SRC}" -maxdepth 1 -mindepth 1 -type d | sort | while read name; do
        local pkg=$(basename "${name}")
        if ! dotf_link_pkg_is_exclude "${pkg}"; then
            dotf_link_stow "${pkg}"
            dotf_link_stow_log "${pkg}"
        fi
    done
}
