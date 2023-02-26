DG_PROXY_HTTP="127.0.0.1:7890"
DG_PROXY_HTTPS="$DG_PROXY_HTTP"
DG_PROXY_SOCKS5="$DG_PROXY_HTTP"
DG_PROXY_X_HTTP="http://$DG_PROXY_HTTP"
DG_PROXY_X_HTTPS="http://$DG_PROXY_HTTPS"
DG_PROXY_X_SOCKS5="socks5://$PROXY_SOCKS5"
DG_PROXY_X_SOCKS5H="socks5h://$PROXY_SOCKS5"

setproxy() {
    export http_proxy="${DG_PROXY_X_HTTP}"
    export https_proxy="${DG_PROXY_X_HTTPS}"
    export all_proxy="${DG_PROXY_X_SOCKS5}"
}

unsetproxy() {
    unset http_proxy https_proxy all_proxy
}

showproxy() {
    echo "http_proxy: ${http_proxy} https_proxy: ${https_proxy} all_proxy: ${all_proxy}"
}

init_proxy() {
    setproxy
}

init_proxy
