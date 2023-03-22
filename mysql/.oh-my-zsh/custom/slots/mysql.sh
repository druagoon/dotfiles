# export MYSQL_PS1="[\u@\h:\p] (\d)[\c] \R:\m:\s \n> "
export MYSQL_PS1="[\R:\m:\s] (\u@\h:\p) [\d]#\c\n> "

__init_mysql() {
    local mysql_prefix="$(brew --repfix mysql@5.7 2>/dev/null)"
    if [[ -d "${mysql_prefix}" ]]; then
        local mysql_bin="${mysql_prefix}/bin"
        if [[ -d "${mysql_bin}" ]]; then
            df_prepend_path "${mysql_bin}"
        fi
    fi
}

__init_mysql
