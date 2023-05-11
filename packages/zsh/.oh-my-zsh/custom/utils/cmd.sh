_dotf::cmd::check() {
    command -v "$1" &>/dev/null
}

_dotf::cmd::path::is_contains() {
    [[ ":${PATH}:" == *":$1:"* ]]
}

_dotf::cmd::path::prepend() {
    if ! _dotf::cmd::path::is_contains "$1"; then
        export PATH="$1:${PATH}"
    fi
}

_dotf::cmd::path::append() {
    if ! _dotf::cmd::path::is_contains "$1"; then
        export PATH="${PATH}:$1"
    fi
}
