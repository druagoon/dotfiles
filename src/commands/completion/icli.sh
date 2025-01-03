# @cmd Generate icli completions
#
# Examples:
#   dotf completion icli
#
# @meta require-tools icli
completion::icli() {
    icli completion zsh >"${DOTF_PKG_ICLI_DIR}/.zcomp/_icli"
}
