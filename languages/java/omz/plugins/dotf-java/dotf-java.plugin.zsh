export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

setjdk() {
    if [[ -x "/usr/libexec/java_home" ]]; then
        local ret="$(/usr/libexec/java_home -v "$@" 2>/dev/null)"
        if [[ -n "${ret}" ]]; then
            export JAVA_HOME="${ret}"
        fi
    fi
}

__dotf_java_init() {
    setjdk 1.8
}

__dotf_java_init
