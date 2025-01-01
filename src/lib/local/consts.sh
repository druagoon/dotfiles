# Global
DOTF_ROOT="${DOTFILES_ROOT:-${HOME}/.dotfiles}"
DOTF_PKG_ROOT="${DOTF_ROOT}/packages"

dotf::pkg::dir::get() {
    local name="$1"
    echo "${DOTF_PKG_ROOT}/${name}"
}

## Layout
DOTF_LAYOUT_DIR="$(dotf::pkg::dir::get "os/layouts")"

## Link
DOTF_LINK_STOW_SRC="${DOTF_PKG_ROOT}"
DOTF_LINK_STOW_TARGET="$(dirname "${DOTF_ROOT}")"
DOTF_LINK_EXCLUDE_PKG=(.git .venv .vscode)
DOTF_LINK_EXCLUDE_PKG_STRING=$(
    IFS=":"
    echo "${DOTF_LINK_EXCLUDE_PKG[*]}"
)

## Brew
DOTF_PKG_BREW="$(dotf::pkg::dir::get brew)"

## Git
DOTF_PKG_GIT="$(dotf::pkg::dir::get git)"
