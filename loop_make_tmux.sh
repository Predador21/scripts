#!/bin/bash

while read session account
do
    echo ""
    echo $session $account

    ./start.sh $session $account

done < <(echo "select session, account from tbl_session where status = 1" | mysql --login-path=$home/config.cnf fenix -s)
