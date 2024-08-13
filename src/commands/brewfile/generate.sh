# @cmd Generate brewfile by `brew bundle dump`
#
# Examples:
#   dotf brewfile generate
#
brewfile::generate() {
    cd "${DOTF_PKG_BREW}" && brew bundle dump --describe --force
}
