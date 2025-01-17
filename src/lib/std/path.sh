std::path::dir::ensure() {
    local dir="$1"
    if [[ ! -d "$dir" ]]; then
        mkdir -p "$dir"
    fi
}

std::path::file::ensure() {
    local file="$1"
    if [[ ! -f "${name}" ]]; then
        touch "$file"
    fi
}

std::path::file::ensure_dir() {
    local file="$1"
    if [[ ! -f "${name}" ]]; then
        local dir="$(dirname "$file")"
        std::path::dir::ensure "$dir"
        touch "$file"
    fi
}
