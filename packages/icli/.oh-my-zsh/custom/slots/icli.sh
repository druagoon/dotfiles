__install_icli() {
    if _dotf::cmd::check cargo; then
        if ! _dotf::cmd::check icli; then
            local repo="https://github.com/druagoon/icli-rs.git"
            echo "Cargo install \"icli\" from: ${repo}"
            cargo install --locked --all-features --git "${repo}"
        fi
    fi
}

__init_icli() {
    __install_icli
}

__init_icli
