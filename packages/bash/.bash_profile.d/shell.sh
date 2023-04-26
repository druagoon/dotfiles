# https://en.wikipedia.org/wiki/ANSI_escape_code

alias la='ls -lAh --color=auto'
alias ll='ls -lh --color=auto'
alias lsa='ls -lah --color=auto'

BLACK="\033[0;30m"
RED="\033[0;31m"
RED_B="\033[1;31m"
RED_I="\033[3;31m"
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
BLUE="\033[0;34m"
PURPLE="\033[0;35m"
CYAN="\033[0;36m"
LIGHT_GRAY="\033[0;37m"
RESET="\033[0m"

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

__ps1_part() {
    echo "${RESET}$1${RESET}"
}

__get_ps1_ip_ifconfig() {
    echo "$(/sbin/ifconfig | grep -v '127.0.0.1' | grep -P -o "((eth[\w:]+)|(em[\d:]+)|(bond[\w:]+)|(inet\s+[\d.]+)|(lo[\d:]*))" | perl -e '%face;foreach (<STDIN>){$int=$1 if (/((?:(?:eth)|(?:lo)|(?:em)|(?:bond))[\d:]*)/);$face{$int}=$1 if (/inet\s+([\d.]+)/);};foreach $interf (sort keys %face){$itf=substr($interf,0,-1); print "$itf=$face{$interf} " if ($interf !~ /^lo$/)}')"
}

__get_ps1_ip() {
    ip=""
    if [[ -x "$(command -v ip)" ]]; then
        ip=$(ip -o -4 addr list | grep -v "127.0.0.1" | awk '{ip=$2"="$4; print ip}' | cut -d/ -f1 | xargs)
    fi
    echo "$ip"
}

__get_ps1_git_status() {
    name="$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [[ -z "${name}" ]]; then
        echo ""
    else
        echo -e "${GREEN}(${RED_B}${name}${GREEN})"
    fi
}

__get_ps1() {
    prefix="$(__ps1_part "\\$ ")"
    user="$(__ps1_part "${PURPLE}\\u")"
    hostname="$(__ps1_part "${RED}\\H")"
    host="${user}@${hostname}"
    ip="$(__ps1_part "${ORANGE}$(__get_ps1_ip)")"
    datetime="$(__ps1_part "${CYAN}\\D{%Y/%m/%d %H:%M:%S}")"
    cwd="$(__ps1_part "${BLUE}\\w")"
    git_status="$(__ps1_part "\$(__get_ps1_git_status)")"
    echo "${prefix}${host} ${ip} ${datetime}\n${prefix}${cwd} ${git_status}\n${prefix}"
}

ldps1() {
    export PS1="$(__get_ps1)"
}

ldprofile() {
    source ~/.bash_profile
}

__init_shell_path() {
    paths=("${HOME}/bin" "${HOME}/.local/bin" /usr/local/sbin /usr/local/bin)
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
