dotf::path::gitkeep::exists() {
    local name="$1/.gitkeep"
    [[ -f "${name}" ]]
}

dotf::path::gitkeep::ensure_dir() {
    local name="$1/.gitkeep"
    std::path::file::ensure_dir "${name}"
}
