#!/bin/bash

while read fingerprint session
do
    echo $fingerprint $session

    ./start.sh $fingerprint  $session

done < <(echo "SELECT fingerprint, session FROM tbl_session where tmux_ok = 'F'" | mysql --login-path=$home/config.cnf fenix -s)
