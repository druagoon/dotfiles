# $1 -> cmd name
# $2 -> cmd repository
# $3 -> cmd alias
__dotf_git_install_go_repo() {
    local go_bin="${GOBIN}"
    if [[ -z "${go_bin}" ]]; then
        local go_path="$(go env GOPATH)"
        if [[ -z "${go_path}" ]]; then
            return
        fi
        go_bin="${go_path}/bin"
    fi

    local name="$1"
    local repo="$2"
    local cmd_alias="$3"
    local cmd="$go_bin/${name}"
    if [[ ! -f "${cmd}" ]]; then
        echo "go install \"${repo}\""
        go install "${repo}"
    fi
    if [[ ! -x "${cmd}" ]]; then
        chmod +x "${cmd}"
    fi

    if [[ -n "${cmd_alias}" ]]; then
        local target="${go_bin}/${cmd_alias}"
        if [[ ! -f "${target}" ]]; then
            (cd "${go_bin}" && ln -sv "./${name}" "${cmd_alias}")
        fi
    fi
}

__dotf_git_install_git_cb() {
    local args=(
        git-checkout-branch
        github.com/royeo/git-checkout-branch@latest
        git-cb
    )
    __dotf_git_install_go_repo "${args[@]}"
}

__dotf_git_install_git_cz() {
    local args=(
        commitizen-go
        github.com/lintingzhen/commitizen-go@latest
        git-cz
    )
    __dotf_git_install_go_repo "${args[@]}"
}

__dotf_git_install_git_ignore() {
    if ! _dotf::cmd::exists git-ignore; then
        echo "brew install git-ignore"
        brew install git-ignore
    fi
}

__dotf_git_install_gibo() {
    if ! _dotf::cmd::exists gibo; then
        echo "brew install gibo"
        brew install gibo
    fi
}

__dotf_git_init() {
    __dotf_git_install_git_cb
    __dotf_git_install_git_cz
    __dotf_git_install_git_ignore
    __dotf_git_install_gibo
}

__dotf_git_init
