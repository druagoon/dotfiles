. ./vars.sh

install_icli() {
    "${DF_VENV_PIP}" install git+ssh://git@github.com/druagoon/icli-python.git@master
}

install_omz() {
    if [[ ! -d "${OMZ_ROOT}" ]]; then
        if [[ "$(command -v curl)" ]]; then
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        elif [[ "$(command -v wget)" ]]; then
            sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
        else
            echo "`curl` or `wget` not found, please install first."
            exit 1
        fi
    fi

    mkdir -p "${OMZ_ROOT}/custom/{completions,slots}"
}

install() {
    install_icli
    install_omz
}

install
