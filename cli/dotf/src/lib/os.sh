dotf::os::platform::is_arm64() {
    local arch="$(uname -m)"
    [[ "${arch}" == "arm64" || "${arch}" == "aarch64" ]]
}
