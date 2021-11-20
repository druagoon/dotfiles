unset MAILCHECK

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="vim"
# export HISTTIMEFORMAT="%F %T "
export PATH=$HOME/.env/macOS/bin:/usr/local/sbin:/usr/local/bin:$PATH

alias zshrl="source ~/.zshrc"
alias flushdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
