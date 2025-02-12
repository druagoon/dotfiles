__dotf_makefile_get_git_branch_words() {
    local prefix="$1"
    local pattern="$2"
    if [[ -n "${pattern}" ]]; then
        git branch --list "${pattern}" --format="${prefix}%(refname:short)"
    else
        git branch --format="${prefix}%(refname:short)"
    fi
}

__dotf_makefile_get_git_branch_action_words() {
    local word="$1"
    local prefix="branch="

    if [[ -z "${word}" ]]; then
        __dotf_makefile_get_git_branch_words "${prefix}"
        return
    fi

    if [[ "$word" == "${prefix}"* ]]; then
        local pattern=""
        local suffix="${word#${prefix}}"
        if [[ -n "${suffix}" ]]; then
            local pattern="${suffix}*"
        fi
        __dotf_makefile_get_git_branch_words "${prefix}" "${pattern}"
        return
    fi
}

__dotf_makefile_get_comp_words() {
    # echo "$(make -qp | sed -n -E 's/^([^.#\s][^:=]*)(:$|:\s+.*$)/\1/p' | grep -E -v "@|/|%|GNUmakefile|Makefile" | sort -u)"
    local word="$1"
    local targets="$(make -qp 2>/dev/null | grep -E -x '^[a-zA-Z0-9_\-]+:(\s+[a-zA-Z0-9_\-]+)*$' | awk -F ':' '{print $1}' | grep -E -v '[Mm]akefile' | sort -u)"
    if [[ -n "${word}" ]]; then
        echo "${targets}" | grep -E "^${word}"
    else
        echo "${targets}"
    fi
}

__dotf_makefile_completion() {
    # local IFS=$'\n'
    COMPREPLY=()
    local word="${COMP_WORDS[COMP_CWORD]}"
    if [[ $COMP_CWORD -eq 1 ]]; then
        COMPREPLY="$(__dotf_makefile_get_comp_words "${word}")"
    elif [[ $COMP_CWORD -eq 2 ]]; then
        local prev="${COMP_WORDS[$COMP_CWORD - 1]}"
        case "${prev}" in
            pull | push | rebase | merge)
                COMPREPLY="$(__dotf_makefile_get_git_branch_action_words "${word}")"
                ;;
        esac
    fi
}

complete -o bashdefault -F __dotf_makefile_completion make
