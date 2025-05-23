# export MYSQL_PS1="[\u@\h:\p] (\d)[\c] \R:\m:\s \n> "
export MYSQL_PS1="[\R:\m:\s] (\u@\h:\p) [\d]#\c\n> "

__dotf_mysql_env_path() {
    local mysql_prefix="$(brew --prefix mysql@5.7 2>/dev/null)"
    if [[ -d "${mysql_prefix}" ]]; then
        local mysql_bin="${mysql_prefix}/bin"
        if [[ -d "${mysql_bin}" ]]; then
            _dotf::env::path::prepend "${mysql_bin}"
        fi
    fi
}

__dotf_mysql_init() {
    __dotf_mysql_env_path
}

__dotf_mysql_init
