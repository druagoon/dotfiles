# Extend oh-my-zsh git-prompt plugin
# https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/git-prompt

function preexec_dotf_update_git_vars() {
    case "$2" in
        make* | argc*)
            __EXECUTED_GIT_COMMAND=1
            ;;
    esac
}

autoload -U add-zsh-hook
add-zsh-hook preexec preexec_dotf_update_git_vars
