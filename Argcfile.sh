#!/usr/bin/env bash

set -e

# @describe Manage dotfiles
# @meta version 0.1.0
# @meta require-tools shfmt

# Project
# BASE_DIR="$(cd "$(dirname "$(realpath "${BASH_SOURCE[0]}")")" >/dev/null 2>&1 && pwd)"

# Dotfiles
DOTFILES_ROOT="${DOTFILES_ROOT:-"${HOME}/.dotfiles"}"
DOTFILES_PKG_ROOT="${DOTFILES_ROOT}/packages"

# Tools
SHFMT_OPTS="-ln=auto -i 4 -ci -bn -w"

fmt_shell() {
    shfmt ${SHFMT_OPTS} "$@"
}

# @cmd Format shell scripts
fmt() {
    return
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
# @meta require-tools taplo
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

# @cmd YAML files tools
# @meta require-tools yamlfmt
yaml() {
    return
}

# @cmd Format all YAML files
yaml::format() {
    yamlfmt .
}

# See more details at https://github.com/sigoden/argc
eval "$(argc --argc-eval "$0" "$@")"
