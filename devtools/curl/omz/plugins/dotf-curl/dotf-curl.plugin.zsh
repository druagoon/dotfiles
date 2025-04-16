CURL_WRITE_FORMAT="${HOME}/.config/curl/write-format.txt"
CURL_UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36"
CURL_MUA="Mozilla/5.0 (iPhone; CPU iPhone OS 11_0_3 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Mobile/15A432 NetType/WIFI"

alias fcurl="curl -w \"@$CURL_WRITE_FORMAT\""
alias fucurl="curl -A \"$CURL_UA\" -w \"@$CURL_WRITE_FORMAT\""
alias fmcurl="curl -A \"$CURL_MUA\" -w \"@$CURL_WRITE_FORMAT\""
