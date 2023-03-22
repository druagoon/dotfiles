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

is_brew_formual_cmd() {
    local ret="0"
    if [[ -x "${BREW_PREFIX}/bin/$1" ]]; then
        ret="1"
    elif [[ -x "${BREW_PREFIX}/sbin/$1" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

install_brew() {
    if [[ "$(is_brew_formual_cmd brew)" == "0" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "install brew ... skip"
    fi
}

install_stow() {
    if [[ "$(is_brew_formual_cmd stow)" == "0" ]]; then
        brew install stow
    else
        echo "install stow ... skip"
    fi
}

install_tree() {
    if [[ "$(is_brew_formual_cmd tree)" == "0" ]]; then
        brew install tree
    else
        echo "install tree ... skip"
    fi
}

install_git() {
    if [[ "$(is_brew_formual_cmd git)" == "0" ]]; then
        brew install git
    else
        echo "install git ... skip"
    fi
}

install_zsh() {
    if [[ "$(is_brew_formual_cmd zsh)" == "0" ]]; then
        brew install zsh

        local brew_zsh="$(which zsh)"
        case $(
            grep -Fx "${brew_zsh}" /etc/shells > /dev/null
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
        echo "install zsh ... skip"
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
        echo "install oh-my-zsh ... skip"
    fi

    # local omz_git=$(git rev-parse --git-dir 2> /dev/null)
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

bootstrap() {
    install_brew
    install_stow
    install_tree
    install_git
    install_zsh
    install_omz
}

bootstrap
