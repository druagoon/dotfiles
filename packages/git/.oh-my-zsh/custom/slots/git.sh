# $1 -> cmd name
# $2 -> cmd repository
# $3 -> cmd alias
__go_install_repo() {
    local gobin="${GOBIN}"
    if [[ -z "${gobin}" ]]; then
        local gopath="$(go env GOPATH)"
        local gobin="${gopath}/bin"
    fi

    local name="$1"
    local repo="$2"
    local alias_="$3"
    local cmd="$gobin/${name}"
    if [[ ! -f "${cmd}" ]]; then
        echo "go install \"${repo}\""
        go install "${repo}"
    fi
    if [[ ! -x "${cmd}" ]]; then
        chmod +x "${cmd}"
    fi

    if [[ -n "${alias_}" ]]; then
        local target="${gobin}/${alias_}"
        if [[ ! -f "${target}" ]]; then
            (cd "${gobin}" && ln -sv "./${name}" "${alias_}")
        fi
    fi
}

__install_git_checkout_branch() {
    local args=(
        git-checkout-branch
        github.com/royeo/git-checkout-branch@latest
        git-cb
    )
    __go_install_repo "${args[@]}"
}

__install_git_commitizen() {
    local args=(
        commitizen-go
        github.com/lintingzhen/commitizen-go@latest
        git-cz
    )
    __go_install_repo "${args[@]}"
}

__install_git_ignore() {
    if ! _dotf::cmd::check git-ignore; then
        echo "brew install git-ignore"
        brew install git-ignore
    fi
}

__install_gibo() {
    if ! _dotf::cmd::check gibo; then
        echo "brew install gibo"
        brew install gibo
    fi
}

__init_git() {
    __install_git_checkout_branch
    __install_git_commitizen
    __install_git_ignore
    __install_gibo
}

__init_git
