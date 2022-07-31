#!/bin/sh
while true
do
    if [ ! -f "/root/remove_me_for_self_destruct" ]; then
        echo "Initiating self-destruct sequence"
        break
    fi
    sleep 1m
done
