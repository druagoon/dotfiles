export PATH=/usr/local/bin:/usr/local/sbin:$PATH

ZPROFILED="$HOME/.zprofile.d"

if [ -d "$ZPROFILED" ]; then
    for f in $ZPROFILED/*.sh; do
        . "$f"
    done
fi
