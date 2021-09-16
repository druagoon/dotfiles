# export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export GO111MODULE=on
export GOPROXY=https://goproxy.io,direct
export PATH=$GOPATH/bin:$PATH

function xgo {
    # base=$(echo $1|cut -d "." -f1)
    base="$1"
    dir="$HOME/Code/Local/practice/x-go/$base"
    file="$dir/main.go"
    if [ ! -d "$dir" ]; then
        mkdir "$dir"
    fi
    touch "$file" && cd "$dir" && code "$file"
}

function gvm_on {
    [[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
}

gvm_on
