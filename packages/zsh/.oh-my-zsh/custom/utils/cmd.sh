dotf::cmd::is_exists() {
    local ret="0"
    if [[ -x "$(command -v $1 2>/dev/null)" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

dotf::cmd::path::is_contains() {
    local ret="0"
    if [[ ":${PATH}:" == *":$1:"* ]]; then
        ret="1"
    fi
    echo "${ret}"
}

dotf::cmd::path::prepend() {
    local ret=$(dotf::cmd::path::is_contains "$1")
    if [[ "${ret}" == "0" ]]; then
        export PATH="$1:${PATH}"
    fi
}

dotf::cmd::path::append() {
    local ret=$(dotf::cmd::path::is_contains "$1")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${PATH}:$1"
    fi
}
