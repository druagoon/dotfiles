PROXY_HTTP="127.0.0.1:7890"
PROXY_HTTPS="$PROXY_HTTP"
PROXY_SOCKS5="$PROXY_HTTP"
PROXY_X_HTTP="http://$PROXY_HTTP"
PROXY_X_HTTPS="http://$PROXY_HTTPS"
PROXY_X_SOCKS5="socks5://$PROXY_SOCKS5"
PROXY_X_SOCKS5H="socks5h://$PROXY_SOCKS5"

alias enproxy='export http_proxy=$PROXY_X_HTTP;export https_proxy=$PROXY_X_HTTPS;export all_proxy=$PROXY_X_SOCKS5H'
alias disproxy="unset http_proxy https_proxy all_proxy"
alias pproxy='echo http_proxy: $http_proxy https_proxy: $https_proxy all_proxy: $all_proxy'

enproxy
