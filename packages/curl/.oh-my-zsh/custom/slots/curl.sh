# Env vars
CURL_WRITE_FORMAT="${HOME}/.config/curl/write-format.txt"
CURL_UA="Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/63.0.3239.84 Safari/537.36"
CURL_UA_MOBILE="Mozilla/5.0 (iPhone; CPU iPhone OS 11_0_3 like Mac OS X) AppleWebKit/604.1.38 (KHTML, like Gecko) Mobile/15A432 NetType/WIFI"

# Alias
alias fcurl="curl -w \"@$CURL_WRITE_FORMAT\""
alias ifcurl="curl -i -w \"@$CURL_WRITE_FORMAT\""
alias imfcurl="curl -i -A \"$CURL_UA_MOBILE\" -w \"@$CURL_WRITE_FORMAT\""
