DF_PROXY_HTTP="127.0.0.1:7890"
DF_PROXY_HTTPS="${DF_PROXY_HTTP}"
DF_PROXY_SOCKS5="${DF_PROXY_HTTP}"
DF_PROXY_X_HTTP="http://${DF_PROXY_HTTP}"
DF_PROXY_X_HTTPS="http://${DF_PROXY_HTTPS}"
DF_PROXY_X_SOCKS5="socks5://${DF_PROXY_SOCKS5}"
DF_PROXY_X_SOCKS5H="socks5h://${DF_PROXY_SOCKS5}"

setproxy() {
    export http_proxy="${DF_PROXY_X_HTTP}"
    export https_proxy="${DF_PROXY_X_HTTPS}"
    export all_proxy="${DF_PROXY_X_SOCKS5}"
}

unsetproxy() {
    unset http_proxy https_proxy all_proxy
}

showproxy() {
    echo "http_proxy: ${http_proxy} https_proxy: ${https_proxy} all_proxy: ${all_proxy}"
}

__init_proxy() {
    setproxy
}

__init_proxy
