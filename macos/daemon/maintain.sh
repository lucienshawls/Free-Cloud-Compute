#!/bin/sh
while true
do
    if [ ! -f "/Users/runner/remove_me_for_self_destruct" ]; then
        echo "Initiating self-destruct sequence"
        break
    fi
    sleep 60
done
