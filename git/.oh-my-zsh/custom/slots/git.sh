# $1 -> cmd name
# $2 -> cmd repository
# $3 -> cmd alias
__go_install_repo() {
    local gobin="${GOBIN}"
    if [[ -z "${gobin}" ]]; then
        local gopath="$(go env GOPATH)"
        local gobin="${gopath}/bin"
    fi

    local repo="$2"
    local cmd="$gobin/$1"
    if [[ ! -f "${cmd}" ]]; then
        echo "go install \"${repo}\""
        go install "${repo}"
    fi
    if [[ -x "${cmd}" ]]; then
        chmod +x "${cmd}"
    fi

    if [[ -n "$3" ]]; then
        local target="${gobin}/$3"
        if [[ ! -f "${target}" ]]; then
            (cd "${gobin}" && ln -sv "./$1" "$3")
        fi
    fi
}

__install_git_checkout_branch() {
    local args=(
        git-checkout-branch
        github.com/royeo/git-checkout-branch@latest
        git-cb
    )
    __go_install_repo ${args[*]}
}

__install_git_commitizen() {
    local args=(
        commitizen-go
        github.com/lintingzhen/commitizen-go@latest
        git-cz
    )
    __go_install_repo ${args[*]}
}

__init_git() {
    __install_git_checkout_branch
    __install_git_commitizen
}

__init_git
