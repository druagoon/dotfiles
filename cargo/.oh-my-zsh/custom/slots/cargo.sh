# Rustup mirror
# 字节跳动
export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

_init_cargo() {
    [[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
}

_init_cargo
