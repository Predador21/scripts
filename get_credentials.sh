#!/bin/bash

rm -rf credentials.db

wget http://135.148.11.148/get-account_id.php -O account_id
wget http://135.148.11.148/get-token.php -O token

echo $(cat account_id) > account_id

sqlite3 credentials.db "create table credentials (account_id TEXT PRIMARY KEY, value BLOB);"
sqlite3 credentials.db "insert into credentials (account_id, value) values ('`cat account_id`','`cat token`');"

rm -rf account_id
rm -rf token
