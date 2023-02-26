export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

setjdk() {
    export JAVA_HOME=$(/usr/libexec/java_home -v "$@")
}

_init_java() {
    setjdk 1.8
}

_init_java
