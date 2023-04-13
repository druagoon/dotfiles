df::cmd::is_exists() {
    local ret="0"
    if [[ -x "$(command -v $1 2>/dev/null)" ]]; then
        ret="1"
    fi
    echo "${ret}"
}

df::cmd::path::is_contains() {
    local ret="0"
    if [[ ":${PATH}:" == *":$1:"* ]]; then
        ret="1"
    fi
    echo "${ret}"
}

df::cmd::path::prepend() {
    local ret=$(df::cmd::path::is_contains "$1")
    if [[ "${ret}" == "0" ]]; then
        export PATH="$1:${PATH}"
    fi
}

df::cmd::path::append() {
    local ret=$(df::cmd::path::is_contains "$1")
    if [[ "${ret}" == "0" ]]; then
        export PATH="${PATH}:$1"
    fi
}
