#!/bin/bash

 file='.'$(openssl rand -hex 12)

 curl -s --request POST \
        --url 'https://oauth2.googleapis.com/token' \
        --header 'content-type: application/x-www-form-urlencoded' \
        --data grant_type=refresh_token \
        --data 'client_id=32555940559.apps.googleusercontent.com' \
        --data client_secret=ZmssLNjJy2998hD4CTg2ejr2 \
        --data refresh_token=$1 > $file


 token=$(jq '.access_token' $file )
 token=${token/'"'/}
 token=${token/'"'/} #VERIFICAR DEPOIS O PQ SÓ FUNCIONA SE DUPLICAR

 rm -rf $file

 file='.'$(openssl rand -hex 12)

 curl -s --request POST \
         --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:start?alt=json' \
         --header 'Authorization: Bearer '$token'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --compressed > $file

 erro1=$(jq '.error.status' $file)
 status1=$(jq '.metadata.state' $file)
 status2=$(jq '.response.environment.state' $file)
 erro2=$(jq '.error.details[0].code' $file)

 echo $erro1
 echo $status1
 echo $status2
 echo $erro2

 rm -rf $file
