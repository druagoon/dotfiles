#!/usr/bin/env zsh

### 修复 git flow 自动补全 ###

# Remove git completion
FILES=(/usr/local/share/zsh/site-functions/_git /usr/local/etc/bash_completion.d/git-flow-completion.bash)
for f in "${FILES[@]}"; do
    if [ -e "$f" ]; then
        rm -rf "$f"
        echo "$f ... removed"
    else
        echo "$f ... not found"
    fi
done

# Delete the completion cache
if [ -e "$ZSH_COMPDUMP" ]; then
    rm -rf "$ZSH_COMPDUMP"
fi

# Restart the zsh session
exec zsh
