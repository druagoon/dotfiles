# Inherited from robbyrussell.zsh-theme
ZSH_THEME_GIT_PROMPT_CACHE="on"

__ps1_part() {
    echo "%{${reset_color}%}$1%{${reset_color}%}"
}

__get_ps1_ip() {
    echo "$(icli ip ps1 2>/dev/null)"
}

__get_ps1() {
    local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
    local now="$(__ps1_part "%{$fg_bold[blue]%}%D{%Y/%m/%d %H:%M:%S}")"
    local user="$(__ps1_part "%{$fg_bold[magenta]%}%n")"
    local at="$(__ps1_part "@")"
    local hostname="$(__ps1_part "%{$fg_bold[red]%}%M")"
    local host="${user}${at}${hostname}"
    local ip="$(__ps1_part "%{$fg_bold[yellow]%}$(__get_ps1_ip)")"
    local cwd="$(__ps1_part "%{$fg[cyan]%}%~")"
    local git_status="$(__ps1_part "\$(git_super_status)")"
    echo "${ret_status}${now} ${ip} ${host}\n${ret_status}${cwd}${git_status}\n${ret_status}"
}

PROMPT="$(__get_ps1)"
