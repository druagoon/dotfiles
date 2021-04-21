#!/bin/bash

### 禁用 CleanMyMac 健康监控 ###

healthmonitor="/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac-X Menu.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/CleanMyMac X HealthMonitor"

chmod 0444 "$healthmonitor"
