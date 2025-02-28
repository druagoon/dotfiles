if [[ -z "${GO111MODULE}" ]]; then
    export GO111MODULE=on
fi
if [[ -z "${GOPROXY}" ]]; then
    export GOPROXY=https://goproxy.cn,direct
fi
if [[ -z "${GOPATH}" ]]; then
    export GOPATH="${HOME}/.go"
fi

__dotf_go_env_path() {
    _dotf::env::path::prepend "${GOPATH}/bin"
}

__dotf_go_init() {
    __dotf_go_env_path
}

__dotf_go_init
