__get_git_branch_words() {
    local prefix="$1"
    local pattern="$2"
    if [[ -n "${pattern}" ]]; then
        git branch --list "${pattern}" --format="${prefix}%(refname:short)"
    else
        git branch --format="${prefix}%(refname:short)"
    fi
}

__get_git_branch_action_words() {
    local word="$1"
    local prefix="branch="

    if [[ -z "${word}" ]]; then
        __get_git_branch_words "${prefix}"
        return
    fi

    if [[ "$word" == "${prefix}"* ]]; then
        local pattern=""
        local suffix="${word#${prefix}}"
        if [[ -n "${suffix}" ]]; then
            local pattern="${suffix}*"
        fi
        __get_git_branch_words "${prefix}" "${pattern}"
        return
    fi
}

__get_make_words() {
    # echo "$(make -qp | sed -n -E 's/^([^.#\s][^:=]*)(:$|:\s+.*$)/\1/p' | grep -E -v "@|/|%|GNUmakefile|Makefile" | sort -u)"
    local word="$1"
    local ret="$(make -qp | grep -E -x '^[a-zA-Z0-9_\-]+:(\s+[a-zA-Z0-9_\-]+)*$' | awk -F ':' '{print $1}' | grep -E -v '[Mm]akefile' | sort -u)"
    if [[ -n "${word}" ]]; then
        echo "${ret}" | grep -E "^${word}"
    else
        echo "${ret}"
    fi
}

__make_completion() {
    # local IFS=$'\n'
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY="$(__get_make_words "${word}")"
    elif [[ $COMP_CWORD -eq 2 ]]; then
        local prev="${COMP_WORDS[$COMP_CWORD - 1]}"
        case "${prev}" in
            pull | push | rebase | merge)
                COMPREPLY="$(__get_git_branch_action_words "${word}")"
                ;;
        esac
    fi
}

complete -o bashdefault -F __make_completion make
