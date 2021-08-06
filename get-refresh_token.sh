#!/bin/bash

 file='.'$(openssl rand -hex 12)

 (sqlite3 /root/.config/gcloud/credentials.db "select value from credentials where account_id = '$1'") > $file

 refresh_token=$(jq '.refresh_token' $file)

 rm -rf $file
