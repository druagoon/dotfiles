# Alias
alias gst="git status"
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias gd="git diff --color"
alias gb="git branch"
alias gco="git checkout"

_init_git() {
    [[ -f "/etc/bash_completion.d/git" ]] && . "/etc/bash_completion.d/git"
}

_init_git
