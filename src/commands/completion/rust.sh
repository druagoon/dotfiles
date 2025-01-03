# @cmd Generate rustup and cargo completions
#
# Examples:
#   dotf completion rust
#
# @meta require-tools rustup,cargo
completion::rust() {
    rustup completions zsh cargo >"${DOTF_PKG_RUST_DIR}/.zcomp/_cargo"
    rustup completions zsh rustup >"${DOTF_PKG_RUST_DIR}/.zcomp/_rustup"
}
