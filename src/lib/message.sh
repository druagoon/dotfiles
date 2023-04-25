utils::message::format() {
    local prefix="$1"
    shift
    local format="$1"
    shift
    printf "${prefix}: ${format}\n" "$@"
}

utils::message::info() {
    local msg="$(utils::message::format "INFO" "$@")"
    green "${msg}"
}

utils::message::warning() {
    local msg="$(utils::message::format "WARNING" "$@")"
    yellow "${msg}"
}

utils::message::error() {
    local msg="$(utils::message::format "ERROR" "$@")"
    red "${msg}" >&2
}

utils::message::fatal() {
    utils::message::error "$@"
    exit 1
}
