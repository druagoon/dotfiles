# Checks if a value exists in an array
_dotf::array::contains() {
    local needle="$1"
    local haystack="$2"
    for v in "${haystack[@]}"; do
        if [[ "$v" == "${needle}" ]]; then
            true
            return
        fi
    done

    false
}
