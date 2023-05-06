export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export GOPATH="${HOME}/.go"

__init_go() {
    _dotf::cmd::path::prepend "${GOPATH}/bin"
}

__init_go
