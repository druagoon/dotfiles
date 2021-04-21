#!/bin/bash

### 删除 CleanMyMac 健康监控 ###

healthmonitor="/Applications/CleanMyMac X.app/Contents/Library/LoginItems/CleanMyMac-X Menu.app/Contents/Library/LoginItems/CleanMyMac X HealthMonitor.app/Contents/MacOS/"
old="CleanMyMac X HealthMonitor"
new="CleanMyMac X HealthMonitor.old"

cd "$healthmonitor" || exit
if [ -f "$old" ]; then
	mv "$old" "$new"
	echo "Ok"
fi
