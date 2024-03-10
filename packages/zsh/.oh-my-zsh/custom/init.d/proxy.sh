DOTF_PROXY_HTTP="127.0.0.1:7890"
DOTF_PROXY_HTTPS="${DOTF_PROXY_HTTP}"
DOTF_PROXY_SOCKS5="${DOTF_PROXY_HTTP}"
DOTF_PROXY_X_HTTP="http://${DOTF_PROXY_HTTP}"
DOTF_PROXY_X_HTTPS="http://${DOTF_PROXY_HTTPS}"
DOTF_PROXY_X_SOCKS5="socks5://${DOTF_PROXY_SOCKS5}"
DOTF_PROXY_X_SOCKS5H="socks5h://${DOTF_PROXY_SOCKS5}"

__localproxy_set() {
    export http_proxy="${DOTF_PROXY_X_HTTP}"
    export https_proxy="${DOTF_PROXY_X_HTTPS}"
    export all_proxy="${DOTF_PROXY_X_SOCKS5}"
}

__localproxy_unset() {
    unset http_proxy https_proxy all_proxy
}

__localproxy_show() {
    echo "http_proxy: ${http_proxy} https_proxy: ${https_proxy} all_proxy: ${all_proxy}"
}

localproxy() {
    case "$1" in
        "set") __localproxy_set ;;
        "unset") __localproxy_unset ;;
        "show") __localproxy_show ;;
        *) echo "Usage: localproxy [set|unset|show]" ;;
    esac
}

complete -W "set unset show" localproxy

__init_proxy() {
    localproxy set
}

__init_proxy
