DOTF_PROXY_HOST="${DOTF_PROXY_HOST:-127.0.0.1}"
DOTF_PROXY_PORT="${DOTF_PROXY_PORT:-7890}"

DOTF_PROXY_HTTP_ADDR="${DOTF_PROXY_HOST}:${DOTF_PROXY_PORT}"
DOTF_PROXY_HTTPS_ADDR="$DOTF_PROXY_HTTP_ADDR"
DOTF_PROXY_SOCKS5_ADDR="${DOTF_PROXY_HOST}:${DOTF_PROXY_PORT}"

DOTF_PROXY_HTTP_URL="http://$DOTF_PROXY_HTTP_ADDR"
DOTF_PROXY_HTTPS_URL="http://$DOTF_PROXY_HTTPS_ADDR"
DOTF_PROXY_SOCKS5_URL="socks5://$DOTF_PROXY_SOCKS5_ADDR"
DOTF_PROXY_SOCKS5H_URL="socks5h://$DOTF_PROXY_SOCKS5_ADDR"

__dotf_shellproxy_show() {
    echo "http_proxy: $http_proxy https_proxy: $https_proxy all_proxy: $all_proxy"
}

__dotf_shellproxy_enable() {
    export http_proxy="$DOTF_PROXY_HTTP_URL"
    export https_proxy="$DOTF_PROXY_HTTPS_URL"
    export all_proxy="$DOTF_PROXY_SOCKS5_URL"
}

__dotf_shellproxy_disable() {
    unset http_proxy https_proxy all_proxy
}

shellproxy() {
    case "$1" in
        "show") __dotf_shellproxy_show ;;
        "enable") __dotf_shellproxy_enable ;;
        "disable") __dotf_shellproxy_disable ;;
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
