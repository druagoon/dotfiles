# Global
DOTF_ROOT="${DOTFILES_ROOT:-${HOME}/.dotfiles}"
DOTF_PKG_ROOT="${DOTF_ROOT}/packages"

## Layout
DOTF_LAYOUT_DIR="${DOTF_PKG_ROOT}/os/layouts"

## Link
DOTF_LINK_STOW_SRC="${DOTF_PKG_ROOT}"
DOTF_LINK_STOW_TARGET="$(dirname "${DOTF_ROOT}")"
DOTF_LINK_EXCLUDE_PKG=(.git .venv .vscode)
DOTF_LINK_EXCLUDE_PKG_STRING=$(
    IFS=":"
    echo "${DOTF_LINK_EXCLUDE_PKG[*]}"
)

## Brew
DOTF_PKG_BREW="${DOTF_PKG_ROOT}/brew"
