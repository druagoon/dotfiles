unset MAILCHECK

# Locale && Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor
export EDITOR="vim"

# History
# export HISTTIMEFORMAT="%F %T "

# Alias
alias rlsh="exec ${SHELL} -l"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias pb64="pbpaste | base64 -D && echo"
alias pb64j="pbpaste | base64 -D | jq --indent 4 -S . | pbcopy && echo 'ok'"
alias pjson="pbpaste | jq --indent 4 -S . | pbcopy && echo 'ok'"

_init_shell_path() {
    paths=(/usr/local/sbin /usr/local/bin)
    for v in "${paths[@]}"; do
        prepend_path "${v}"
    done
}

_init_shell() {
    _init_shell_path
}

_init_shell
