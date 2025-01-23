#!/usr/bin/env bash

set -e

## Color functions
##
## Usage:
## Use any of the functions below to color or format a portion of a string.
##
##   echo "before $(std::color::red this is red) after"
##   echo "before $(std::color::green_bold this is green_bold) after"
##
## Color output will be disabled if `NO_COLOR` environment variable is set
## in compliance with https://no-color.org/
##
std::color::display() {
    local color="$1"
    shift
    if [[ -z ${NO_COLOR+x} ]]; then
        printf "${color}%b\e[0m\n" "$*"
    else
        printf "%b\n" "$*"
    fi
}

std::color::red() { std::color::display "\e[31m" "$*"; }
std::color::green() { std::color::display "\e[32m" "$*"; }
std::color::yellow() { std::color::display "\e[33m" "$*"; }
std::color::blue() { std::color::display "\e[34m" "$*"; }
std::color::magenta() { std::color::display "\e[35m" "$*"; }
std::color::cyan() { std::color::display "\e[36m" "$*"; }
std::color::bold() { std::color::display "\e[1m" "$*"; }
std::color::underlined() { std::color::display "\e[4m" "$*"; }
std::color::red_bold() { std::color::display "\e[1;31m" "$*"; }
std::color::green_bold() { std::color::display "\e[1;32m" "$*"; }
std::color::yellow_bold() { std::color::display "\e[1;33m" "$*"; }
std::color::blue_bold() { std::color::display "\e[1;34m" "$*"; }
std::color::magenta_bold() { std::color::display "\e[1;35m" "$*"; }
std::color::cyan_bold() { std::color::display "\e[1;36m" "$*"; }
std::color::red_underlined() { std::color::display "\e[4;31m" "$*"; }
std::color::green_underlined() { std::color::display "\e[4;32m" "$*"; }
std::color::yellow_underlined() { std::color::display "\e[4;33m" "$*"; }
std::color::blue_underlined() { std::color::display "\e[4;34m" "$*"; }
std::color::magenta_underlined() { std::color::display "\e[4;35m" "$*"; }
std::color::cyan_underlined() { std::color::display "\e[4;36m" "$*"; }

export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

write_log() {
    if [[ $? -eq 0 ]]; then
        local result="$(std::color::green_bold OK)"
    else
        local result="$(std::color::red_bold ERROR)"
    fi
    printf "Install %-8s [ %s ]\n" "$1" "${result}"
}

abort() {
    printf "%s\n" "$@" >&2
    exit 1
}

std::cmd::exists() {
    command -v "$1" >/dev/null 2>&1
}

std::os::is_macos() {
    [[ "$(uname)" == "Darwin" ]]
}

std::os::is_arm64() {
    local arch="$(uname -m)"
    [[ "${arch}" == "arm64" || "${arch}" == "aarch64" ]]
}

if ! std::os::is_macos; then
    abort "Only supported on macOS."
fi

if std::os::is_arm64; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
BREW_BIN="${BREW_PREFIX}/bin"
BREW_SBIN="${BREW_PREFIX}/sbin"
BREW_EXEC="${BREW_BIN}/brew"

brew::install() {
    "${BREW_EXEC}" install "$1"
}

brew::cmd::exists() {
    [[ -x "${BREW_BIN}/${1}" || -x "${BREW_SBIN}/${1}" ]]
}

install_os() {
    mkdir -p "${HOME}"/.local/{bin,sbin}
    write_log os
}

install_brew() {
    if [[ ! -f "${BREW_EXEC}" ]]; then
        bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$("$BREW_EXEC" shellenv)"
    fi
    write_log brew
}

install_zsh() {
    if ! brew::cmd::exists zsh; then
        brew::install zsh

        local brew_zsh="${BREW_BIN}/zsh"
        case $(
            grep -Fx "${brew_zsh}" /etc/shells >/dev/null 2>&1
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
    local omz_root="${HOME}/.oh-my-zsh"
    if [[ ! -d "${omz_root}" ]]; then
        if std::cmd::exists curl; then
            bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif std::cmd::exists wget; then
            bash -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        else
            echo "curl or wget not found, please install first."
            exit 1
        fi
    fi
    write_log omz
}

install_rust() {
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
    local -a deps=(
        argc
        bash
        druagoon/brew/icli:icli
        gawk
        git
        gnu-sed:gsed
        go
        stow
        uv
    )

    local name bin
    for item in "${deps[@]}"; do
        name="${item%%:*}"
        bin="${item##*:}"
        if ! brew::cmd::exists "${bin}"; then
            brew::install "${name}"
        fi
        write_log "${bin}"
    done
}

main() {
    install_os
    install_brew
    install_zsh
    install_omz
    install_rust
    install_deps
}

main
