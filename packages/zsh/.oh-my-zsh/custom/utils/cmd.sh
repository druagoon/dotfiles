_dotf::cmd::check() {
    command -v "$1" &>/dev/null
}

_dotf::cmd::path::is_contains() {
    local ret="0"
    if [[ ":${PATH}:" == *":$1:"* ]]; then
        ret="1"
    fi
    echo "${ret}"
}

_dotf::cmd::path::prepend() {
    local ret=$(_dotf::cmd::path::is_contains "$1")
    if [[ "${ret}" == "0" ]]; then
        export PATH="$1:${PATH}"
    fi
}

_dotf::cmd::path::append() {
    local ret=$(_dotf::cmd::path::is_contains "$1")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${PATH}:$1"
    fi
}
