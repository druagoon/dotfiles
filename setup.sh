arch="$(uname -m)"
if [[ "${arch}" == "arm64" ]]; then
    BREW_PREFIX="/opt/homebrew"
else
    BREW_PREFIX="/usr/local"
fi

check_command() {
    ret="0"
    if [[ -x "${BREW_PREFIX}/bin/${1}" ]]; then
        ret="1"
    elif [[ -x "${BREW_PREFIX}/sbin/${1}" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

add_brew_path() {
    export PATH="${BREW_PREFIX}/bin:${BREW_PREFIX}/sbin:${PATH}"
}

install_brew() {
    if [[ "$(check_command brew)" == "0" ]]; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    add_brew_path
}

install_git() {
    if [[ "$(check_command git)" == "0" ]]; then
        brew install git
    fi
}

install_zsh() {
    if [[ "$(check_command zsh)" == "0" ]]; then
        brew install zsh
    fi

    chsh -s $(which zsh)
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
    fi

    mkdir -p "${OMZ_ROOT}/custom/{completions,slots}"
}

bootstrap() {
    install_brew
    install_git
    install_omz
}

bootstrap
