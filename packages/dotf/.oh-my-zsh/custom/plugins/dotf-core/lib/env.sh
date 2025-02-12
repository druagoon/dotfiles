_dotf::env::path::contains() {
    [[ ":${PATH}:" == *":$1:"* ]]
}

_dotf::env::path::prepend() {
    if ! _dotf::env::path::contains "$1"; then
        export PATH="$1:${PATH}"
    fi
}

_dotf::env::path::append() {
    if ! _dotf::env::path::contains "$1"; then
        export PATH="${PATH}:$1"
    fi
}
