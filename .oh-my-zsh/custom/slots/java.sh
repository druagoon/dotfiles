export JAVA_TOOL_OPTIONS=-Dfile.encoding=UTF-8

function setjdk() {
    export JAVA_HOME=`/usr/libexec/java_home -v $@`
}
setjdk 1.8
