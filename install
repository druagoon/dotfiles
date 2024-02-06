#!/usr/bin/env bash

set -e

## Color functions [@bashly-upgrade colors]
## This file is a part of Bashly standard library
##
## Usage:
## Use any of the functions below to color or format a portion of a string.
##
##   echo "before $(red this is red) after"
##   echo "before $(green_bold this is green_bold) after"
##
## Color output will be disabled if `NO_COLOR` environment variable is set
## in compliance with https://no-color.org/
##
print_in_color() {
    local color="$1"
    shift
    if [[ -z ${NO_COLOR+x} ]]; then
        printf "$color%b\e[0m\n" "$*"
    else
        printf "%b\n" "$*"
    fi
}

red() { print_in_color "\e[31m" "$*"; }
green() { print_in_color "\e[32m" "$*"; }
yellow() { print_in_color "\e[33m" "$*"; }
blue() { print_in_color "\e[34m" "$*"; }
magenta() { print_in_color "\e[35m" "$*"; }
cyan() { print_in_color "\e[36m" "$*"; }
bold() { print_in_color "\e[1m" "$*"; }
underlined() { print_in_color "\e[4m" "$*"; }
red_bold() { print_in_color "\e[1;31m" "$*"; }
green_bold() { print_in_color "\e[1;32m" "$*"; }
yellow_bold() { print_in_color "\e[1;33m" "$*"; }
blue_bold() { print_in_color "\e[1;34m" "$*"; }
magenta_bold() { print_in_color "\e[1;35m" "$*"; }
cyan_bold() { print_in_color "\e[1;36m" "$*"; }
red_underlined() { print_in_color "\e[4;31m" "$*"; }
green_underlined() { print_in_color "\e[4;32m" "$*"; }
yellow_underlined() { print_in_color "\e[4;33m" "$*"; }
blue_underlined() { print_in_color "\e[4;34m" "$*"; }
magenta_underlined() { print_in_color "\e[4;35m" "$*"; }
cyan_underlined() { print_in_color "\e[4;36m" "$*"; }

is_arm64() {
    local arch="$(uname -m)"
    [[ "${arch}" == "arm64" || "${arch}" == "aarch64" ]]
}

get_brew_prefix() {
    local prefix=""
    if is_arm64; then
        prefix="/opt/homebrew"
    else
        prefix="/usr/local"
    fi
    echo "${prefix}"
}

BREW_PREFIX="$(get_brew_prefix)"
BREW_BIN="${BREW_PREFIX}/bin"
BREW_SBIN="${BREW_PREFIX}/sbin"
BREW_EXEC="${BREW_BIN}/brew"

OMZ_ROOT="${HOME}/.oh-my-zsh"
OMZ_CUSTOM="${OMZ_ROOT}/custom"

export PATH="${BREW_BIN}/bin:${BREW_SBIN}/sbin:${PATH}"
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

write_log() {
    if [[ $? -eq 0 ]]; then
        local result="$(green_bold OK)"
    else
        local result="$(red_bold ERROR)"
    fi
    printf "Install %-8s [ %s ]\n" "$1" "${result}"
}

check_brew_formual_cmd() {
    [[ -x "${BREW_BIN}/${1}" || -x "${BREW_SBIN}/${1}" ]]
}

check_cmd() {
    command -v "$1" >/dev/null 2>&1
}

brew_install() {
    "${BREW_EXEC}" install "$1"
}

install_os() {
    mkdir -p "${HOME}"/{.zcomp,.zfunc}
    mkdir -p "${HOME}"/.local/{bin,sbin}
    write_log os
}

install_brew() {
    if [[ ! -f "${BREW_EXEC}" ]]; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    write_log brew
}

install_zsh() {
    if ! check_brew_formual_cmd zsh; then
        brew_install zsh

        local brew_zsh="${BREW_BIN}/zsh"
        case $(
            grep -Fx "${brew_zsh}" /etc/shells >/dev/null
            echo $?
        ) in
            0) ;;
            1)
                echo "add ${brew_zsh} to /etc/shells"
                echo ${brew_zsh} | sudo tee -a /etc/shells
                ;;
            *)
                echo "an error occurred, program exit."
                exit 1
                ;;
        esac
        echo "change shell to: ${brew_zsh}"
        chsh -s ${brew_zsh}
    fi
    write_log zsh
}

install_omz() {
    if [[ ! -d "${OMZ_ROOT}" ]]; then
        if check_cmd curl; then
            bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif check_cmd wget; then
            bash -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        else
            echo "curl or wget not found, please install first."
            exit 1
        fi
    fi
    write_log omz
}

install_cargo() {
    local root="${HOME}/.cargo"
    local config="${root}/config.toml"
    local rustup="${root}/bin/rustup"
    if [[ ! -f "${rustup}" ]]; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
        if [[ -f "${config}" ]]; then
            mv "${config}" "${config}.bak"
        fi
    fi
    write_log cargo
}

install_deps() {
    local deps=(bash stow git go pyenv rbenv)
    for key in "${deps[@]}"; do
        if ! check_brew_formual_cmd "${key}"; then
            brew_install "${key}"
        fi
        write_log "${key}"
    done
}

main() {
    install_os
    install_brew
    install_zsh
    install_omz
    install_cargo
    install_deps
}

main
