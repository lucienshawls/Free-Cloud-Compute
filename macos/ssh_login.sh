#!/usr/bin/expect
set timeout 3
spawn ssh root@127.0.0.1 -o StrictHostKeyChecking=no
expect "*ass*"
send "Temp810@975\r"
expect "*#*"
send "whoami\r"
expect timeout
exit