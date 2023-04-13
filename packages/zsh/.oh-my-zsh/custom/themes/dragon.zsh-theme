# Inherited from robbyrussell.zsh-theme
ZSH_THEME_GIT_PROMPT_CACHE="on"

DF_NEWLINE=$'\n'
DF_IPADDRS="$(${DF_VENV_ICLI} ip shell 2>/dev/null)"

local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
PROMPT='${ret_status}%{$fg_bold[yellow]%}%p ${DF_IPADDRS} %{$fg_bold[magenta]%}%n%{$fg_bold[blue]%}@%{$fg_bold[red]%}%p%M${DF_NEWLINE}${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%~%{$reset_color%}$(git_super_status)%{$reset_color%} % %{$reset_color%} ${DF_NEWLINE}${ret_status} %{$reset_color%}'

# Backup
# DF_IPADDRS=`/sbin/ifconfig|grep -v "127.0.0.1"|grep -P -o "((eth[\w:]+)|(em[\d:]+)|(bond[\w:]+)|(inet\s+[\d.]+)|(lo[\d:]*))" | perl -e '%face;foreach (<STDIN>){$int=$1 if (/((?:(?:eth)|(?:lo)|(?:em)|(?:bond))[\d:]*)/);$face{$int}=$1 if (/inet\s+([\d.]+)/);};foreach $interf (sort keys %face){print "$interf = $face{$interf}  " if ($interf !~ /^lo$/)}'`

# PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%}'
# PROMPT='${ret_status}%{$fg_bold[yellow]%}%p ${DF_IPADDRS} ${DF_NEWLINE}${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%} ${DF_NEWLINE}${ret_status} %{$reset_color%}'
