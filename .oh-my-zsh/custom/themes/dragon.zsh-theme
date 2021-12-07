# Inherited from robbyrussell.zsh-theme
ZSH_THEME_GIT_PROMPT_CACHE="on"
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status}%{$fg_bold[yellow]%}%p ${IPADDRS} %{$fg_bold[magenta]%}%n%{$fg_bold[blue]%}@%{$fg_bold[red]%}%p%M${NEWLINE}${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%} ${NEWLINE}${ret_status} %{$reset_color%}'
