#!/bin/bash

 file='.'$(openssl rand -hex 12)
 file='get-refresh_token.log'

 (sqlite3 /root/.config/gcloud/credentials.db "select value from credentials where account_id = '$1'") > $file

 refresh_token=$(jq '.refresh_token' $file)
 refresh_token=${refresh_token//'"'/}

 if [ $file != 'get-refresh_token.log' ]
 then
    rm -rf $file
 fi

 if [ $2 == true ]
 then
    echo $refresh_token
 fi
