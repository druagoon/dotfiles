_dotf::os::platform::is_arm64() {
    local ret="0"
    local arch="$(uname -m)"
    if [[ "${arch}" == "arm64" || "${arch}" == "aarch64" ]]; then
        ret="1"
    fi
    echo "${ret}"
}
