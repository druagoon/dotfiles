__init_cargo() {
    [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
}

__init_rust() {
    __init_cargo
}

__init_rust
