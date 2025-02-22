ZPROFILED="${HOME}/.zprofile.d"
ZPROFILED_LOCAL="${HOME}/.zprofile.d/local"

__load_zprofile_shells() {
    for dir in "$@"; do
        if [[ -d "${dir}" ]]; then
            for f in "${dir}"/*.(sh|zsh)(N); do
                if [[ -r "$f" ]]; then
                    . "$f"
                fi
            done
        fi
    done
}

__load_zprofile_shells "${ZPROFILED}" "${ZPROFILED_LOCAL}"

unfunction __load_zprofile_shells
