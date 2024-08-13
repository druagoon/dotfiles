std::string::strip() {
    sed -e 's/^ *//' -e 's/ *$//' <<<"$1"
}

std::string::strip_prefix() {
    sed 's/^ *//' <<<"$1"
}

std::string::strip_suffix() {
    sed 's/ *$//' <<<"$1"
}
