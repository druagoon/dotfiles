#!/usr/bin/env bash

set -e

# @describe Generate and build the dotf script
# @meta version 0.1.0
# @meta author lazyboy <lazyboy.fan@gmail.com>
# @meta require-tools shfmt,taplo,icli

# Project
# BASE_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" >/dev/null 2>&1 && pwd)"
NAME="dotf"
BASE_DIR="${ARGC_PWD}"
SRC_DIR="${BASE_DIR}/src"
SRC_MAIN="${SRC_DIR}/main.sh"
TARGET_DIR="${BASE_DIR}/target"
TARGET_CLI="${TARGET_DIR}/${NAME}"

# Dotfiles
DOTFILES_ROOT="${HOME}/.dotfiles"
DOTFILES_PKG_ROOT="${DOTFILES_ROOT}/packages"
DOTF_FILE="${DOTFILES_ROOT}/${NAME}"

# Link
LINK_TARGET="${HOME}/.local/bin/${NAME}"

# Tools
SHFMT_OPTS="-ln=auto -i 4 -ci -bn -w"

get_pkg_dir() {
    local name="$1"
    echo "${DOTFILES_PKG_ROOT}/${name}"
}

get_pkg_omz_custom_dir() {
    local name="$1"
    local pkg_dir=$(get_pkg_dir "${name}")
    echo "${pkg_dir}/.oh-my-zsh/custom"
}

get_pkg_omz_plugin_path() {
    local pkg_name="$1"
    local plugin_name="${2:-"${pkg_name}"}"
    local pkg_omz_dir=$(get_pkg_omz_custom_dir "${pkg_name}")
    echo "${pkg_omz_dir}/plugins/${plugin_name}/${plugin_name}.plugin.zsh"
}

get_dotf_cli_plugin_path() {
    get_pkg_omz_plugin_path "${NAME}" dotf-cli
}

fmt_shell() {
    shfmt ${SHFMT_OPTS} "$@"
}

# # @cmd Generate executable bash script
# # @meta require-tools gawk
# generate() {
#     local temp="${TARGET_DIR}/main.sed"
#     gawk -v src_dir="${SRC_DIR}" '
#         match($0, /^include "(.+?)"/, r) {
#             gsub(/(^ +)|( +$)/, "", r[1])
#             printf "%s r %s/%s\n", FNR, src_dir, r[1]
#         }
#     ' "${SRC_MAIN}" >"${temp}"
#     if [[ ! -d "${TARGET_DIR}" ]]; then
#         mkdir -p "${TARGET_DIR}"
#     fi
#     sed -f "${temp}" "${SRC_MAIN}" >"${TARGET_CLI}"
#     _fmt "${TARGET_CLI}"
#     chmod +x "${TARGET_CLI}"

#     # Build
#     argc --argc-build "${TARGET_CLI}" "${DOTF_FILE}"
#     _fmt "${DOTF_FILE}"
#     chmod +x "${DOTF_FILE}"
# }

# @cmd Generate and build bash script without the argc dependency
build() {
    icli shinc build -vv
    fmt::target
    cp -v "${TARGET_CLI}" "${DOTF_FILE}"
}

# @cmd Manage dotf cli completions
completions() {
    return
}

# @cmd Generate dotf cli zsh completions
completions::generate() {
    local output="$(get_dotf_cli_plugin_path)"
    icli shinc completion zsh >"${output}"
    fmt_shell "${output}"
}

# @cmd Format shell scripts
fmt() {
    return
}

# @cmd Format shell scripts in `./src`
fmt::src() {
    fmt_shell "${SRC_DIR}"
}

# @cmd Format shell scripts in `./target`
fmt::target() {
    fmt_shell "${TARGET_DIR}"
}

# @cmd Format shell scripts in `./packages`
fmt::pkg() {
    fmt_shell "${DOTFILES_PKG_ROOT}"
}

# @cmd Format shell scripts in current directory
fmt::all() {
    fmt_shell .
}

# @cmd TOML files tools
toml() {
    return
}

# @cmd Format all TOML files
toml::format() {
    taplo format
}

# @cmd Check all TOML files
toml::check() {
    taplo format --check
}

# # @cmd Crate symbolic link for dotf
# link() {
#     ln -sfv "${DOTF_FILE}" "${LINK_TARGET}"
# }

# # @cmd Remove the symbolic link of dotf
# unlink() {
#     rm -f "${LINK_TARGET}"
# }

# @cmd Build and release the dotf script and make symbolic link
# @meta require-tools gawk,sed,shfmt
release() {
    build
    completions::generate
    # link
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
