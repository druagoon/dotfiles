is_path_contains() {
    ret="0"
    if [[ ":${PATH}:" != *":${1}:"* ]]; then
        ret="1"
    fi
    echo "${ret}"
}

prepend_path() {
    ret=$(is_path_contains "${1}")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${1}:${PATH}"
    fi
}

append_path() {
    ret=$(is_path_contains "${1}")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${PATH}:${1}"
    fi
}
