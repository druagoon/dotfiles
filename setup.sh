#!/bin/bash

arch="$(uname -m)"
if [[ "${arch}" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
export PATH="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${PATH}"
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

OMZ_ROOT="${HOME}/.oh-my-zsh"
OMZ_CUSTOM="${OMZ_ROOT}/custom"

is_cmd_with_brew() {
    local ret="0"
    if [[ -x "${BREW_PREFIX}/bin/$1" ]]; then
        ret="1"
    elif [[ -x "${BREW_PREFIX}/sbin/$1" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

say() {
    printf "%-7s %-4s ... %s\n" "$1" "$2" "$3"
}

say_install_skip() {
    say install "$1" skip
}

say_install_done() {
    say install "$1" done
}

install_os() {
    mkdir -p "${HOME}"/{.zcomp,.zfunc}
    mkdir -p "${HOME}"/.local/{bin,sbin}
    say_install_done os
}

install_brew() {
    if [[ "$(is_cmd_with_brew brew)" == "0" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        say_install_skip brew
    fi
}

install_stow() {
    if [[ "$(is_cmd_with_brew stow)" == "0" ]]; then
        brew install stow
    else
        say_install_skip stow
    fi
}

install_tree() {
    if [[ "$(is_cmd_with_brew tree)" == "0" ]]; then
        brew install tree
    else
        say_install_skip tree
    fi
}

install_git() {
    if [[ "$(is_cmd_with_brew git)" == "0" ]]; then
        brew install git
    else
        say_install_skip git
    fi
}

install_zsh() {
    if [[ "$(is_cmd_with_brew zsh)" == "0" ]]; then
        brew install zsh

        local brew_zsh="$(which zsh)"
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
        if [[ "$(command -v curl)" ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif [[ "$(command -v wget)" ]]; then
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
    if [[ "$(is_cmd_with_brew go)" == "0" ]]; then
        brew install go
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
