#!/bin/bash

COUNT=$1

echo "Count: $1"

if [ "$#" -ne 1 ]; then
    echo Sending 1 notification
    COUNT=1
fi

for i in $(seq 1 "$COUNT"); do
    notify-send "Test $i" "This is a test notification" --app-name "Discord"
    notify-send "Test $i" "This is a test notification" --app-name "Firefox"
    notify-send "Test $i" "This is a test notification" --app-name "League"
done
