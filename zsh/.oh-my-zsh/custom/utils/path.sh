df::path::directory::is_empty() {
    local ret="1"
    if [[ -d "$1" && -n "$(ls -A "$1")" ]]; then
        ret="0"
    fi
    echo "${ret}"
}
