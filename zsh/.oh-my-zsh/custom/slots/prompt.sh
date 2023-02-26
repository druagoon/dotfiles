NEWLINE=$'\n'
IPADDRS=`${CONDA_DOTFILES_PYTHON} ${ZSH_CUSTOM}/bin/shell-ip-prompt.py`

# IPADDRS=`/sbin/ifconfig|grep -v "127.0.0.1"|grep -P -o "((eth[\w:]+)|(em[\d:]+)|(bond[\w:]+)|(inet\s+[\d.]+)|(lo[\d:]*))" | perl -e '%face;foreach (<STDIN>){$int=$1 if (/((?:(?:eth)|(?:lo)|(?:em)|(?:bond))[\d:]*)/);$face{$int}=$1 if (/inet\s+([\d.]+)/);};foreach $interf (sort keys %face){print "$interf = $face{$interf}  " if ($interf !~ /^lo$/)}'`

# PROMPT='${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%}'
# PROMPT='${ret_status}%{$fg_bold[yellow]%}%p ${IPADDRS} ${NEWLINE}${ret_status}%{$fg_bold[green]%}%p %{$fg[cyan]%}%d %{$fg_bold[blue]%}$(git_super_status)%{$fg_bold[blue]%} % %{$reset_color%} ${NEWLINE}${ret_status} %{$reset_color%}'
