#!/bin/bash

 file='.'$(openssl rand -hex 12)
 file='get-bearer.log'

 curl -s --request POST \
         --url 'https://oauth2.googleapis.com/token' \
         --header 'content-type: application/x-www-form-urlencoded' \
         --data grant_type=refresh_token \
         --data 'client_id=32555940559.apps.googleusercontent.com' \
         --data client_secret=ZmssLNjJy2998hD4CTg2ejr2 \
         --data refresh_token=$1 > $file

 token=$(jq '.access_token' $file )
 token=${token//'"'/}

 if [ $file != 'get-bearer.log' ]
 then
    rm -rf $file
 fi

