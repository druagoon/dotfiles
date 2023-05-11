unset MAILCHECK

# Locale && Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor
export EDITOR="vim"

# History
# export HISTTIMEFORMAT="%F %T "

# Alias
alias shrl="source ~/.zshrc"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias pb64="pbpaste | base64 -D && echo"
alias pb64j="pbpaste | base64 -D | jq --indent 4 -S . | pbcopy && echo 'ok'"
alias pjson="pbpaste | jq --indent 4 -S . | pbcopy && echo 'ok'"

ppath() {
    printf -- '-%.0s' {1..100}
    printf -- '\n'
    echo ${PATH//:/'\n'}
    printf -- '-%.0s' {1..100}
    printf -- '\n'
}

__init_terminal_tabstop() {
    if _dotf::cmd::check tabs; then
        tabs -4
    fi
}

__init_shell_path() {
    paths=(/usr/local "${HOME}/.local")
    for v in "${paths[@]}"; do
        _dotf::cmd::path::prepend "${v}/sbin"
        _dotf::cmd::path::prepend "${v}/bin"
    done
}

__init_shell() {
    __init_shell_path
    __init_terminal_tabstop
}

__init_shell
