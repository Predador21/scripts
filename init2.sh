#!/bin/bash

status1='null'
token='null'

while true
do

 echo
 date
 echo

 if [ $token == 'null' ] || [ $status1 == 'UNAUTHENTICATED' ]
 then
    source get-bearer.sh $1
 fi

 file='.'$(openssl rand -hex 12)

 curl -s --request POST \
         --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:start?alt=json' \
         --header 'Authorization: Bearer '$token'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --compressed > $file

 user=$(jq '.response.environment.sshUsername' $file)
 status1=$(jq '.error.status' $file)
 status2=$(jq '.metadata.state' $file)
 status3=$(jq '.response.environment.state' $file)
 status4=$(jq '.error.details[0].code' $file)

 user=${user//'"'/}
 status1=${status1//'"'/}
 status2=${status2//'"'/}
 status3=${status3//'"'/}
 status4=${status4//'"'/}

 echo 'user:    '$user
 echo 'status1: '$status1
 echo 'status2: '$status2
 echo 'status3: '$status3
 echo 'status4: '$status4

 rm -rf $file

 sleep 60

 done
