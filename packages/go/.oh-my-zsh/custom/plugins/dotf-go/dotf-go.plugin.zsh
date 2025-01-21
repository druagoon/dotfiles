export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export GOPATH="${HOME}/.go"

__dotf_go_env_path() {
    _dotf::cmd::path::prepend "${GOPATH}/bin"
}

__dotf_go_init() {
    __dotf_go_env_path
}

__dotf_go_init
