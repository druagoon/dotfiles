# export GOROOT=/usr/local/opt/go/libexec
export GO111MODULE=on
# export GOPROXY=https://goproxy.io,direct
# export GOPROXY=https://goproxy.cn,direct
export GOPATH="${HOME}/.go"

_init_go() {
    prepend_path "${GOPATH}/bin"
}

_init_go
