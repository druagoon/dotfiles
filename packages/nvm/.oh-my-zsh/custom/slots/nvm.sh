export NVM_DIR="${HOME}/.nvm"

__load_nvm() {
    # Load nvm
    local prefix="$(brew --prefix nvm)"
    local nvm_sh="${prefix}/nvm.sh"
    if [[ -s "${nvm_sh}" ]]; then
        . "${nvm_sh}"
    fi

    # Load nvm completion
    local nvm_completion="${prefix}/etc/bash_completion.d/nvm"
    if [[ -s "${nvm_completion}" ]]; then
        . "${nvm_completion}"
    fi
}

__init_nvm() {
    __load_nvm
}

__init_nvm
