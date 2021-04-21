#!/bin/bash

CURRENT_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
FILENAME="$CURRENT_DIR/scan-mac-dir"

while read -r line; do
    if [ ! "${line:0:1}" = "#" ]; then
        eval path="$line"
        echo "[$path]"
        ls -l "$path" | grep -i "$1" || echo '...'
    fi
done <"$FILENAME"
