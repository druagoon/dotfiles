_dotf::path::dir::is_empty() {
    [[ ! (-d "$1" && -n "$(ls -A "$1")") ]]
}
