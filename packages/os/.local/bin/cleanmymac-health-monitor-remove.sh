#!/bin/bash

### 删除 CleanMyMac 健康监控 ###
FILES=(
    "/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/CleanMyMac X HealthMonitor"
    "/Applications/CleanMyMac-X.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/CleanMyMac X HealthMonitor"
)

main() {
    for f in "${FILES[@]}"; do
        if [[ -f "$f" ]]; then
            local backup="${f}.bak"
            local dname="$(dirname "$f")"
            mv "$f" "${backup}" && echo "Ok" && ls -lA "${dname}" && exit 0
        fi
    done

    echo "exec file not found."
    exit 1
}

main
