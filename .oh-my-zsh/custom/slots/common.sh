unset MAILCHECK

export LC_ALL=en_US.UTF-8
export EDITOR="vim"
export PATH=$HOME/local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:$PATH

alias zshrl="source ~/.zshrc"
alias flushdns="dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
