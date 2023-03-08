# export GOROOT=/usr/local/opt/go/libexec
export GO111MODULE=on
# export GOPROXY=https://goproxy.io,direct
# export GOPROXY=https://goproxy.cn,direct
export GOPATH="${HOME}/.go"

__init_go() {
    df_prepend_path "${GOPATH}/bin"
}

__init_go
