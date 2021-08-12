#!/bin/bash

owner=$(echo /home/g*)
owner=${owner#/home/}

status1='null'
token='null'
addPublicKey='null'
commandOk='null'

while true
do

 echo

 if [ $token == 'null' ] || [ $status1 == 'UNAUTHENTICATED' ]
 then
    source get-bearer.sh $1
 fi

 source get-operation.sh $token
 status1=$status_operation

 if [ $status1 != 'UNAUTHENTICATED' ]
 then

 file='.'$(openssl rand -hex 12)
 file='init.log'

 curl -s --request GET \
         --url 'https://cloudshell.googleapis.com/v1/'$operation'?alt=json' \
         --header 'Authorization: Bearer '$token'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --compressed > $file
 user=$(jq '.response.environment.name' $file)
 sshUsername=$(jq '.response.environment.sshUsername' $file)
 sshHost=$(jq '.response.environment.sshHost' $file)
 status1=$(jq '.error.status' $file)
 status2=$(jq '.metadata.state' $file)
 status3=$(jq '.response.environment.state' $file)
 status4=$(jq '.error.details[0].code' $file)

 user=${user//'users/'/}
 user=${user//'/environments/default'/}
 user=${user//'"'/}

 sshUsername=${sshUsername//'"'/}
 sshHost=${sshHost//'"'/}

 status1=${status1//'"'/} #UNAUTHENTICATED
 status2=${status2//'"'/} #STARTING/FINISHED
 status3=${status3//'"'/} #RUNNING
 status4=${status4//'"'/} #ERROS

fi

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

 echo $status

 if [ $addPublicKey == 'null' ] && [ $status == 'RUNNING' ]
 then
     source addPublicKey.sh $token $sshHost
 fi

 if [ $addPublicKey == 'true' ] && [ $commandOk == 'null' ]
 then
    source command.sh $sshUsername $sshHost 'date'
    commandOk='true'
 fi

 url='http://135.148.11.148/send_status.php?refresh='$1'&status='$status'&owner='$owner
 curl $url

 if [ $file != 'init.log' ]
 then
    rm -rf $file
 fi

 sleep 60

 done
