alias ldsh="source ~/.zshrc"
alias flushdns="dscacheutil -flushcache; sudo killall -HUP mDNSResponder"
alias pb64="pbpaste | base64 -D && echo"
alias pb64j="pbpaste | base64 -D | jq --indent 4 -S . | pbcopy && echo 'ok'"
alias pjson="pbpaste | jq --indent 4 -S . | pbcopy && echo 'ok'"

pfpath() {
    print -l $fpath | sed "s#^${HOME}#~#g"
}

ppath() {
    echo "$PATH" | sed -e 's/:/\n/g' | sed -e "s#^${HOME}#~#"
}

__dotf_shell_init_terminal_tabstop() {
    if command -v tabs >/dev/null 2>&1; then
        tabs -4
    fi
}

__dotf_shell_init() {
    __dotf_shell_init_terminal_tabstop
}

__dotf_shell_init
