if [[ -f ~/.bashrc ]]; then
    . ~/.bashrc
fi

if [[ -d ~/.bash_profile.d/utils ]]; then
    for v in ~/.bash_profile.d/utils/*.sh; do
        . "${v}"
    done
fi

if [[ -d ~/.bash_profile.d/plugins ]]; then
    for v in ~/.bash_profile.d/plugins/*.sh; do
        . "${v}"
    done
fi
