# Rustup mirror
# 字节跳动
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

__init_cargo() {
    [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
}

__init_rust() {
    __init_cargo
}

__init_rust
