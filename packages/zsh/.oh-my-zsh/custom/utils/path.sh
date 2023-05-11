_dotf::path::directory::is_empty() {
    if [[ -d "$1" && -n "$(ls -A "$1")" ]]; then
        false
        return
    fi

    true
}
