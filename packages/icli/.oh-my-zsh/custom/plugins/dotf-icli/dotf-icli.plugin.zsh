__dotf_icli_install_exec() {
    if _dotf::cmd::exists cargo; then
        if ! _dotf::cmd::exists icli; then
            local repo="https://github.com/druagoon/icli-rs.git"
            echo "Cargo install \"icli\" from: ${repo}"
            cargo install --locked --all-features --git "${repo}"
        fi
    fi
}

__dotf_icli_init() {
    __dotf_icli_install_exec
}

__dotf_icli_init
