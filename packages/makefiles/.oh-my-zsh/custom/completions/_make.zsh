# Branch: pull-bugfix/typo ==> pull-bugfix@typo
__get_git_branch_words() {
    local prefix="$1"
    local pattern="$2"
    if [[ -n "${pattern}" ]]; then
        git branch --list "${pattern}" --format="${prefix}%(refname:short)" | sed -e 's#/#@#g'
    else
        git branch --format="${prefix}%(refname:short)" | sed -e 's#/#@#g'
    fi
}

__get_git_branch_action_words() {
    local word="$1"
    local actions=(pull- push- rebase- merge-)
    for act in "${actions[@]}"; do
        if [[ "${word}" == "${act}"* ]]; then
            local suffix="${word#${act}}"
            if [[ -n "${suffix}" ]]; then
                # Pattern: bugfix@ ==> bugfix/
                local pattern="${suffix//@//}*"
            else
                local pattern=""
            fi
            __get_git_branch_words "${act}" "${pattern}"
            return
        fi
    done
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
    COMPREPLY=""
    local word="$2"
    case "${word}" in
        pull-* | push-* | rebase-* | merge-*)
            COMPREPLY="$(__get_git_branch_action_words "${word}")"
            ;;
        *)
            if [[ "${word}" == "--" && $COMP_CWORD -eq 1 ]]; then
                word=""
            fi
            COMPREPLY="$(__get_make_words "${word}")"
            ;;
    esac
}

complete -o bashdefault -F __make_completion make
