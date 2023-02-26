#!/bin/bash

arch="$(uname -m)"
if [[ "${arch}" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi
export PATH="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${PATH}"
export https_proxy=http://127.0.0.1:7890 http_proxy=http://127.0.0.1:7890 all_proxy=socks5://127.0.0.1:7890

check_command() {
    ret="0"
    if [[ -x "${BREW_PREFIX}/bin/${1}" ]]; then
        ret="1"
    elif [[ -x "${BREW_PREFIX}/sbin/${1}" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

install_brew() {
    if [[ "$(check_command brew)" == "0" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    else
        echo "install brew ... skip"
    fi
}

install_git() {
    if [[ "$(check_command git)" == "0" ]]; then
        brew install git
    else
        echo "install git ... skip"
    fi
}

install_zsh() {
    if [[ "$(check_command zsh)" == "0" ]]; then
        brew install zsh

        brew_zsh="$(which zsh)"
        case $(grep -Fx "${brew_zsh}" /etc/shells >/dev/null; echo $?) in
            0)
                ;;
            1)
                echo "add ${brew_zsh} to /etc/shells"
                echo ${brew_zsh} | sudo tee -a /etc/shells
                ;;
            *)
                echo "an error occurred"
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
    OMZ_ROOT="${HOME}/.oh-my-zsh"
    if [[ ! -d "${OMZ_ROOT}" ]]; then
        if [[ "$(command -v curl)" ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif [[ "$(command -v wget)" ]]; then
            /bin/bash -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        else
            echo "`curl` or `wget` not found, please install first."
            exit 1
        fi
    else
        echo "install oh-my-zsh ... skip"
    fi

    if [[ -d "${OMZ_ROOT}/.git" ]]; then
        mkdir -p ${OMZ_ROOT}/custom/{completions,slots}
    fi
}

install_stow() {
    if [[ "$(check_command stow)" == "0" ]]; then
        brew install stow
    else
        echo "install stow ... skip"
    fi
}

bootstrap() {
    install_brew
    install_git
    install_zsh
    install_omz
    install_stow
}

bootstrap
