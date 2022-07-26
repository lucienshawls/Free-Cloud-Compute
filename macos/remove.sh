#!/usr/bin/expect
set timeout 3
spawn sudo passwd runner
expect "Changing password for runner."
expect "New password:"
send "Temp810@975\r"
expect "Retype new password:"
send "Temp810@975\r"
expect eof
exit