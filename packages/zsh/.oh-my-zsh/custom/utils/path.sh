_dotf::path::directory::is_empty() {
    [[ ! (-d "$1" && -n "$(ls -A "$1")") ]]
}
