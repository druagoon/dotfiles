export GO111MODULE=on
export GOPROXY=https://goproxy.cn,direct
export GOPATH="${HOME}/.go"

__init_go() {
    df::cmd::path::prepend "${GOPATH}/bin"
}

__init_go
