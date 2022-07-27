@echo off
:loop
if not exist "D:\remove_me_for_self_destruct" (
    echo "Initiating self-destruct sequence"
    goto end_of_loop
)
sleep 60
goto loop
:end_of_loop
