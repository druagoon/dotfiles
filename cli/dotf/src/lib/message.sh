dotf::utils::message::format() {
    local prefix="$1"
    shift
    local format="$1"
    shift
    printf "${prefix}: ${format}\n" "$@"
}

dotf::utils::message::info() {
    local msg="$(dotf::utils::message::format "INFO" "$@")"
    green "${msg}"
}

dotf::utils::message::warning() {
    local msg="$(dotf::utils::message::format "WARNING" "$@")"
    yellow "${msg}"
}

dotf::utils::message::error() {
    local msg="$(dotf::utils::message::format "ERROR" "$@")"
    red "${msg}" >&2
}

dotf::utils::message::fatal() {
    dotf::utils::message::error "$@"
    exit 1
}
