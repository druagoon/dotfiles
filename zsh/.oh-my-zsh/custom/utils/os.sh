df_is_arm64() {
    ret="0"
    arch="$(uname -m)"
    if [[ "${arch}" == "arm64" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

df_is_command_executable() {
    ret="0"
    if [[ -x "$(command -v ${1} 2> /dev/null)" ]]; then
        ret="1"
    fi
    echo "${ret}"
}
