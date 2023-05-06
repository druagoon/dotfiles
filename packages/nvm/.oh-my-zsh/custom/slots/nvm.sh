export NVM_DIR="${HOME}/.nvm"

__load_nvm() {
    if [[ "$(_dotf::cmd::is_exists nvm)" ]]; then
        if [[ ! -d "${NVM_DIR}" ]]; then
            mkdir -p "${NVM_DIR}"
        fi

        # Load nvm
        local prefix="$(brew --prefix nvm)"
        if [[ -s "${prefix}/nvm.sh" ]]; then
            . "${prefix}/nvm.sh"
        fi

        # Load nvm completion
        if [[ -s "${prefix}/etc/bash_completion.d/nvm" ]]; then
            . "${prefix}/etc/bash_completion.d/nvm"
        fi
    fi
}

__init_nvm() {
    __load_nvm
}

__init_nvm
