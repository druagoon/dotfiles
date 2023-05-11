# Checks if a value exists in an array
_dotf::array::is_exists() {
    local value="$1"
    local arr="$2"
    for v in "${arr[@]}"; do
        if [[ "$v" == "${value}" ]]; then
            true
            return
        fi
    done

    false
}
