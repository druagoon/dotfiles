__init_makefile_completion() {
    # complete -W "\`grep -oE '^[a-zA-Z0-9_.-]+:([^=]|$)' ?akefile | grep -v ".PHONY" | sed 's/[^a-zA-Z0-9_.-]*$//' | sort -u\`" make
    complete -W "\`make -qp | sed -n -E 's/^([^.#\s][^:=]*)(:$|:\s+.*$)/\1/p' | grep -v "/" | grep -v "^%" | sort -u\`" make
}

__init_makefile() {
    __init_makefile_completion
}

__init_makefile
