ZPROFILED="${HOME}/.zprofile.d"

if [ -d "${ZPROFILED}" ]; then
    for f in "${ZPROFILED}"/*.zsh; do
        . "${f}"
    done
fi
