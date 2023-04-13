#!/bin/bash

### 删除 CleanMyMac 健康监控 ###

HEALTH_MONITOR_DIR="/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/"
old="CleanMyMac X HealthMonitor"
new="CleanMyMac X HealthMonitor.old"

if [ -d "$HEALTH_MONITOR_DIR" ]; then
    cd "$HEALTH_MONITOR_DIR"
else
    echo "HealthMonitor directory not found."
    exit
fi

if [ -f "$old" ]; then
    mv "$old" "$new" && echo "Ok" && ls -l "$HEALTH_MONITOR_DIR"
else
    echo "exec file not found."
fi
