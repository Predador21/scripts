#!/bin/bash

query=$(mysql --login-path=$home/config.cnf fenix -se "select fingerprint, session from tbl_session where tmux_ok = 'F'")
read fingerprint session <<< $query

echo $fingerprint
echo $session

./start.sh $session
