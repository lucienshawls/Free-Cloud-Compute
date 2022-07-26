#!/usr/bin/expect
set timeout 3
spawn sudo passwd root
expect "Changing password for root."
expect "New password:"
send "Temp810@975\r"
expect "Retype new password:"
send "Temp810@975\r"
expect eof
exit