alias ls='ls --color=auto'
alias lsa='ls -Ah'
alias ll='ls -lh'
alias la='ls -lAh'

alias ldsh='source ~/.zshrc'
alias flushdns='dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias ppath='echo "$PATH" | sed -e "s/:/\\n/g" | sed -e "s#^${HOME}#~#"'
alias pfpath='print -l $fpath | sed "s#^${HOME}#~#g"'

__dotf_shell_init_terminal_tabstop() {
    # Set tabstop to 4 spaces
    if command -v tabs >/dev/null 2>&1; then
        tabs -4
    fi
}

__dotf_shell_init() {
    __dotf_shell_init_terminal_tabstop
}

__dotf_shell_init
