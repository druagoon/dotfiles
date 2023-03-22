unset MAILCHECK

# Locale && Language
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor
export EDITOR="vim"

# History
# export HISTTIMEFORMAT="%F %T "

# Alias
alias shrl="exec ${SHELL} -l"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias pb64="pbpaste | base64 -D && echo"
alias pb64j="pbpaste | base64 -D | jq --indent 4 -S . | pbcopy && echo 'ok'"
alias pjson="pbpaste | jq --indent 4 -S . | pbcopy && echo 'ok'"

__init_shell_path() {
    paths=(/usr/local ${HOME}/.local)
    for v in "${paths[@]}"; do
        df_prepend_path "${v}/sbin"
        df_prepend_path "${v}/bin"
    done
}

__init_shell() {
    __init_shell_path
}

__init_shell
