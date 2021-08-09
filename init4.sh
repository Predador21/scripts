#!/bin/bash

owner=${USER//'_'/'.'}

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

 echo 'token: '$token

 source get-operation.sh $token
 status1=$status_operation

 echo 'status operation: '$status_operation
 echo 'operaton: '$operation
 echo

 if [ $status1 != 'UNAUTHENTICATED' ]
 then
 file='.'$(openssl rand -hex 12)

 curl -s --request GET \
         --url 'https://cloudshell.googleapis.com/v1/'$operation'?alt=json' \
         --header 'Authorization: Bearer '$token'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --compressed > $file

 user=$(jq '.response.environment.name' $file)
 status1=$(jq '.error.status' $file)
 status2=$(jq '.metadata.state' $file)
 status3=$(jq '.response.environment.state' $file)
 status4=$(jq '.error.details[0].code' $file)

 user=${user//'users/'/}
 user=${user//'/environments/default'/}
 user=${user//'"'/}

 status1=${status1//'"'/} #UNAUTHENTICATED
 status2=${status2//'"'/} #STARTING/FINISHED
 status3=${status3//'"'/} #RUNNING
 status4=${status4//'"'/} #ERROS

fi

 echo 'user:    '$user
 echo 'status1: '$status1
 echo 'status2: '$status2
 echo 'status3: '$status3
 echo 'status4: '$status4

 if [ $status1 != 'null' ]
 then
    status=$status1
 else
    if [ $status4 != 'null' ]
    then
       status=$status4
    else
       if [ $status3 != 'null' ]
       then
          status=$status3
       else
          status=$status2
       fi
    fi
 fi

 echo 'status final: '$status

 url='http://135.148.11.148/send_status.php?refresh='$1'&status='$status'&owner='$owner
 curl $url

 rm -rf $file

 sleep 60

 done
