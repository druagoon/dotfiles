unset MAILCHECK

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="vim"
# export HISTTIMEFORMAT="%F %T "
export PATH=$HOME/.env/macOS/bin:/usr/local/sbin:/usr/local/bin:$PATH

alias zshrl="source ~/.zshrc"
alias flushdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias pb64="pbpaste | base64 -D && echo"
alias pb64j="pbpaste | base64 -D | jq --indent 4 -S . | pbcopy && echo 'ok'"
alias pjson="pbpaste | jq --indent 4 -S . | pbcopy && echo 'ok'"
