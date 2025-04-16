__dotf_rust_init_cargo() {
    local cargo_env="${HOME}/.cargo/env"
    [[ -f "${cargo_env}" ]] && . "${cargo_env}"
}

__dotf_rust_init() {
    __dotf_rust_init_cargo
}

__dotf_rust_init
