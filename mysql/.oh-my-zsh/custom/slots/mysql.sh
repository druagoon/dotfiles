# export MYSQL_PS1="[\u@\h:\p] (\d)[\c] \R:\m:\s \n> "
export MYSQL_PS1="[\R:\m:\s] (\u@\h:\p) [\d]#\c\n> "

_init_mysql() {
    prepend_path "/usr/local/opt/mysql@5.7/bin"
}

_init_mysql
