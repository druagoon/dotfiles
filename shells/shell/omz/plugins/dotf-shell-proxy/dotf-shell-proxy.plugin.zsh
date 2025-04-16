DOTF_PROXY_HTTP="127.0.0.1:7890"
DOTF_PROXY_HTTPS="${DOTF_PROXY_HTTP}"
DOTF_PROXY_SOCKS5="${DOTF_PROXY_HTTP}"
DOTF_PROXY_X_HTTP="http://${DOTF_PROXY_HTTP}"
DOTF_PROXY_X_HTTPS="http://${DOTF_PROXY_HTTPS}"
DOTF_PROXY_X_SOCKS5="socks5://${DOTF_PROXY_SOCKS5}"
DOTF_PROXY_X_SOCKS5H="socks5h://${DOTF_PROXY_SOCKS5}"

__dotf_shell_proxy_show() {
    echo "http_proxy: ${http_proxy} https_proxy: ${https_proxy} all_proxy: ${all_proxy}"
}

__dotf_shell_proxy_enable() {
    export http_proxy="${DOTF_PROXY_X_HTTP}"
    export https_proxy="${DOTF_PROXY_X_HTTPS}"
    export all_proxy="${DOTF_PROXY_X_SOCKS5}"
}

__dotf_shell_proxy_disable() {
    unset http_proxy https_proxy all_proxy
}

shellproxy() {
    case "$1" in
        "show") __dotf_shell_proxy_show ;;
        "enable") __dotf_shell_proxy_enable ;;
        "disable") __dotf_shell_proxy_disable ;;
        *) echo "Usage: shellproxy [show|enable|disable]" ;;
    esac
}

shellproxy enable

__dotf_shellproxy() {
    local -a commands
    commands=(
        "show:Show shell network proxy status"
        "enable:Enable shell network proxy"
        "disable:Disable shell network proxy"
    )
    _describe 'shell network proxy manager' commands
}

compdef __dotf_shellproxy shellproxy
