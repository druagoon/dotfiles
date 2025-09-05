alias ls='ls --color=auto'
alias lsa='ls -A'
alias ll='ls -lh'
alias la='ls -lhA'
alias lf='ls -lhF'
alias lfa='ls -lhAF'

alias ldsh='source ~/.zshrc'
alias clhist='yes | history -c'
alias flushdns='dscacheutil -flushcache; sudo killall -HUP mDNSResponder'
alias ppath='echo "$PATH" | sed -e "s/:/\\n/g" | sed -e "s#^${HOME}#~#"'
alias pfpath='print -l $fpath | sed "s#^${HOME}#~#g"'

# Set tabstop to 4 spaces
if command -v tabs >/dev/null 2>&1; then
    tabs -4
fi
