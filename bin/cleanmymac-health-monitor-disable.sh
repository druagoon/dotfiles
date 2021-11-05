#!/bin/bash

### 禁用 CleanMyMac 健康监控 ###

HEALTH_MONITOR_DIR="/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac-X Menu.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/"
FILENAME="CleanMyMac X HealthMonitor"

if [ -d "$HEALTH_MONITOR_DIR" ]; then
    cd "$HEALTH_MONITOR_DIR"
else
    echo "HealthMonitor directory not found."
    exit
fi

if [ -f "$FILENAME" ]; then
    chmod 0444 "$FILENAME" && echo "Ok" && ls -l "$HEALTH_MONITOR_DIR"
else
    echo "exec file not found."
fi
