# @cmd Generate golang completions
#
# Examples:
#   dotf completion go
#
# @meta require-tools wget
completion::go() {
    local source="https://raw.githubusercontent.com/zsh-users/zsh-completions/refs/heads/master/src/_golang"
    wget -q -O "${DOTF_PKG_GO_DIR}/.zcomp/_golang" "${source}"
}
