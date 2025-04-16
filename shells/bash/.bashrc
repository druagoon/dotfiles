load_bashrc_d() {
    for v in "$@"; do
        if [[ -d "$v" ]]; then
            for file in $(find "$v" -type f -name "*.sh"); do
                . "${file}"
            done
        elif [[ -r "$v" ]]; then
            . "$v"
        fi
    done
}

load_bashrc_d ~/.bashrc.d/libs ~/.bashrc.d/plugins
