__init_cargo() {
    local cargo_env="${HOME}/.cargo/env"
    [[ -f "${cargo_env}" ]] && . "${cargo_env}"
}

__init_rust() {
    __init_cargo
}

__init_rust
