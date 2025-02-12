# Handle $0 according to the standard:
# https://zdharma-continuum.github.io/Zsh-100-Commits-Club/Zsh-Plugin-Standard.html
0="${${ZERO:-${0:#$ZSH_ARGZERO}}:-${(%):-%N}}"
0="${${(M)0:#/*}:-$PWD/$0}"

__DOTF_CORE_DIR="${0:A:h}"

__load_dotf_core_libraries() {
    for f in "${__DOTF_CORE_DIR}"/lib/*.sh(N); do
        . "$f"
    done
}

__load_dotf_core_libraries

unset __DOTF_CORE_DIR
unfunction __load_dotf_core_libraries
