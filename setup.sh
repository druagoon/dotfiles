#!/usr/bin/env bash

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

export PATH="${BREW_BIN}/bin:${BREW_SBIN}/sbin:${PATH}"
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

OMZ_ROOT="${HOME}/.oh-my-zsh"
OMZ_CUSTOM="${OMZ_ROOT}/custom"

check_brew_formual_cmd() {
    [[ -x "${BREW_BIN}/${1}" || -x "${BREW_SBIN}/${1}" ]]
}

check_cmd() {
    command -v "$1" > /dev/null 2>&1
}

say() {
    printf "%-7s %-4s ... %s\n" "$1" "$2" "$3"
}

say_install_skip() {
    say install "$1" skip
}

say_install_done() {
    say install "$1" ok
}

brew_install() {
    "${BREW_EXEC}" install "$1"
}

install_os() {
    mkdir -p "${HOME}"/{.zcomp,.zfunc}
    mkdir -p "${HOME}"/.local/{bin,sbin}
    say_install_done os
}

install_brew() {
    if [[ ! -f "${BREW_EXEC}" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        say_install_skip brew
    fi
}

install_stow() {
    if ! check_brew_formual_cmd stow; then
        brew_install stow
    else
        say_install_skip stow
    fi
}

install_tree() {
    if ! check_brew_formual_cmd tree; then
        brew_install tree
    else
        say_install_skip tree
    fi
}

install_git() {
    if ! check_brew_formual_cmd git; then
        brew_install git
    else
        say_install_skip git
    fi
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
    else
        say_install_skip zsh
    fi
}

install_omz() {
    if [[ ! -d "${OMZ_ROOT}" ]]; then
        if check_cmd curl; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif check_cmd wget; then
            /bin/bash -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        else
            echo "curl or wget not found, please install first."
            exit 1
        fi
    else
        say_install_skip omz
    fi

    # local omz_git=$(git rev-parse --git-dir 2>/dev/null)
    # if [[ -n "${omz_git}" ]]; then
    #     local initialized="${OMZ_CUSTOM}/__initialized__"
    #     if [[ ! -f "${initialized}" ]]; then
    #         echo "list files in: ${OMZ_CUSTOM}"
    #         tree "${OMZ_CUSTOM}"
    #         read -p "Delete directory: ${OMZ_CUSTOM} [Y/n] " answer
    #         case ${answer} in
    #             Y | y)
    #                 rm -rf "${OMZ_CUSTOM}"
    #                 ;;
    #             *)
    #                 echo "process abort, program exit."
    #                 exit 1
    #                 ;;
    #         esac
    #     fi
    #     touch "${initialized}"
    # fi
}

install_go() {
    if ! check_brew_formual_cmd go; then
        brew_install go
    else
        say_install_skip go
    fi
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
    else
        say_install_skip rust
    fi
}

setup() {
    install_os
    install_brew
    install_stow
    install_tree
    install_git
    install_zsh
    install_omz
    install_go
    install_rust
}

setup
