#!/bin/bash

while read session account
do
    echo $session $account

    ./start.sh $session $account

done < <(echo "select session, account from tbl_session where tmux_ok = 'F'" | mysql --login-path=$home/config.cnf fenix -s)
