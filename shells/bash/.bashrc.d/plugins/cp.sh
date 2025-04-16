cpv() {
    rsync -pogbr -hhh --backup-dir="/tmp/rsync-${USER}" -e /dev/null --progress "$@"
}

cpvg() {
    rsync -pogbr -hhh --exclude '.git' --backup-dir="/tmp/rsync-${USER}" -e /dev/null --progress "$@"
}

complete -d -f cpv cpvg
