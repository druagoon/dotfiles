#!/usr/bin/env zsh

### 修复 git flow 自动补全 ###

# Remove git completion
FILES=(/usr/local/share/zsh/site-functions/_git /usr/local/etc/bash_completion.d/git-flow-completion.bash)
for f in "${FILES[@]}"; do
    if [ -e "$f" ]; then
        rm -rf "$f"
        echo "$f ... removed"
    fi
done

#if [ -e "/usr/local/share/zsh/site-functions/_git" ]; then
#    rm -rf "/usr/local/share/zsh/site-functions/_git"
#fi
#if [ -e "/usr/local/etc/bash_completion.d/git-flow-completion.bash" ]; then
#    rm -rf "/usr/local/etc/bash_completion.d/git-flow-completion.bash"
#fi

# Delete the completion cache
if [ -e "$ZSH_COMPDUMP" ]; then
    rm -rf "$ZSH_COMPDUMP"
fi

# Restart the zsh session
exec zsh
