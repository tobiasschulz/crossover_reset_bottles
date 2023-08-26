#!/usr/bin/env bash

test -f /opt/homebrew/bin/pidof || brew install pidof

PWD=/Applications/CrossOver.app/Contents/MacOS

PROC_NAME=CrossOver

# get all pids of CrossOver
pids=(`pgrep "$PROC_NAME"`, `pidof "$PROC_NAME"`, `ps -Ac | grep -m1 '"$PROC_NAME"\$' | awk '{print \$1}'`)
pids=`echo $pids|tr ',' ' '`

# kills CrossOver process if it is running
[ "$pids" ] && kill -9 `echo $pids` >/dev/null 2>&1

sleep 3

TIME=`date -v -1H '+%b %d, %Y, %H:%M:%S %p'`

# modify time in order to reset trial
plutil -replace FirstRunDate -string "$TIME" ~/Library/Preferences/com.codeweavers.CrossOver.plist

# reset all bottles
for file in ~/Library/Application\ Support/CrossOver/Bottles/*/.{eval,update-timestamp}; do rm -rf "$file";done
