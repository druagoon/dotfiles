# https://en.wikipedia.org/wiki/ANSI_escape_code

alias la='ls -lAh --color=auto'
alias ll='ls -lh --color=auto'
alias lsa='ls -lah --color=auto'

colortest() {
    for x in {0..8}; do
        for i in {30..37}; do
            echo -ne "\e[${x};${i}m\\\e[${x};${i}m\e[0;37m "
        done
        echo
    done
    echo ""
}

bgcolortest() {
    for x in {0..8}; do
        for i in {30..37}; do
            for a in {40..47}; do
                echo -ne "\e[${x};${i};${a}m\\\e[${x};${i};${a}m\e[0;37;40m "
            done
            echo
        done
    done
    echo ""
}

__check_cmd() {
    command -v "$1" &>/dev/null
}

__get_ip_by_ifconfig() {
    echo "$(ifconfig | grep -v '127.0.0.1' | grep -P -o "((eth[\w:]+)|(em[\d:]+)|(bond[\w:]+)|(inet\s+[\d.]+)|(lo[\d:]*))" | perl -e '%face;foreach (<STDIN>){$int=$1 if (/((?:(?:eth)|(?:lo)|(?:em)|(?:bond))[\d:]*)/);$face{$int}=$1 if (/inet\s+([\d.]+)/);};foreach $interf (sort keys %face){$itf=substr($interf,0,-1); print "$itf=$face{$interf} " if ($interf !~ /^lo$/)}')"
}

__get_ip_by_ip() {
    echo "$(ip -o -4 addr list | grep -v "127.0.0.1" | awk '{ip=$2"="$4; print ip}' | cut -d/ -f1 | xargs)"
}

__get_ip() {
    local ip=""
    if __check_cmd ip; then
        ip="$(__get_ip_by_ip 2>/dev/null)"
    elif __check_cmd ifconfig; then
        ip="$(__get_ip_by_ifconfig 2>/dev/null)"
    fi
    echo "${ip}"
}

__get_ps1_ip() {
    local ip="$(__get_ip)"
    if [[ -n "${ip}" ]]; then
        printf " %s" "$(yellow "${ip}")"
    else
        printf ""
    fi
}

__get_ps1_git_status() {
    local name="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [[ -n "${name}" ]]; then
        printf " %s%s%s" "$(green '(')" "$(red "${name}")" "$(green ')')"
    else
        printf ""
    fi
}

__get_ps1_os() {
    local ret="$(uname -sm)"
    if __check_cmd lsb_release; then
        local distrib="$(lsb_release -sir 2>/dev/null)"
        if [[ -n "${distrib}" ]]; then
            ret+=" ${distrib}"
        fi
    fi
    echo "(${ret})"
}

__get_ps1() {
    local prefix='\$'
    local user="$(magenta '\\u')"
    local hostname="$(red '\\H')"
    local at="$(blue '@')"
    local host="${user}${at}${hostname}"
    local os="$(__get_ps1_os)"
    local ip="$(__get_ps1_ip)"
    local now="$(cyan '\\D{%Y/%m/%d %H:%M:%S}')"
    local cwd="$(blue '\\w')"
    local git_status='$(__get_ps1_git_status)'
    echo -e "${prefix} ${now}${ip} ${host} ${os}\n${prefix} ${cwd}${git_status}\n${prefix} "
}

ldps1() {
    export PS1="$(__get_ps1)"
}

ldprofile() {
    source ~/.bash_profile
}

__init_shell_path() {
    local paths=(/usr/local/sbin /usr/local/bin "${HOME}/bin" "${HOME}/.local/bin")
    for v in "${paths[@]}"; do
        if [[ ":${PATH}:" != *":${v}:"* ]]; then
            export PATH="${v}:${PATH}"
        fi
    done
}

__init_shell() {
    __init_shell_path
}

__init_shell
