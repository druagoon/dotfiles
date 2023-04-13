if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

if [[ -d ~/.bash_profile.d ]]; then
    for v in ~/.bash_profile.d/*.sh; do
        . "${v}"
    done
fi
