#!/bin/sh
while true
do
    if [ ! -f "/root/remove_me_to_self_destruct" ]; then
        echo "Initiate self-destruct"
        break
    fi
    sleep 1m
done
