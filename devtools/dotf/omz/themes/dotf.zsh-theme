# Inherited from robbyrussell.zsh-theme
ZSH_THEME_GIT_PROMPT_CACHE="on"

__dotf_theme_ps1_part() {
    echo "%{${reset_color}%}$1%{${reset_color}%}"
}

__dotf_theme_ps1_ip() {
    echo "$(icli ip ps1 2>/dev/null)"
}

__dotf_theme_ps1() {
    local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
    local now="$(__dotf_theme_ps1_part "%{$fg_bold[blue]%}%D{%Y/%m/%d %H:%M:%S}")"
    local user="$(__dotf_theme_ps1_part "%{$fg_bold[magenta]%}%n")"
    local at="$(__dotf_theme_ps1_part "@")"
    local hostname="$(__dotf_theme_ps1_part "%{$fg_bold[red]%}%M")"
    local host="${user}${at}${hostname}"
    local ip="$(__dotf_theme_ps1_part "%{$fg_bold[yellow]%}$(__dotf_theme_ps1_ip)")"
    local cwd="$(__dotf_theme_ps1_part "%{$fg[cyan]%}%~")"
    local git_status="$(__dotf_theme_ps1_part "\$(git_super_status)")"
    echo "${ret_status}${now} ${ip} ${host}\n${ret_status}${cwd}${git_status}\n${ret_status}"
}

PROMPT="$(__dotf_theme_ps1)"
RPROMPT=""
