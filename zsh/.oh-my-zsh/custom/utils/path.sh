df_is_path_contains() {
    ret="0"
    if [[ ":${PATH}:" == *":${1}:"* ]]; then
        ret="1"
    fi
    echo "${ret}"
}

df_prepend_path() {
    ret=$(df_is_path_contains "${1}")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${1}:${PATH}"
    fi
}

df_append_path() {
    ret=$(df_is_path_contains "${1}")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${PATH}:${1}"
    fi
}
