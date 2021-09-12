#!/bin/bash

path=$(pwd)
user=${path#/home/}

file='.'${0##*/} && file=${file%.*}'.tmp'

while true
do   
   status1='null'
   status_operation='null'
    
   curl -s 'http://135.148.11.148/queue.php?owner='$user > $file

   account=$(jq '.account' $file)
   account=${account//'"'/}

   refresh_token=$(jq '.refresh_token' $file)
   refresh_token=${refresh_token//'"'/}
   
   bearer=$(jq '.bearer' $file)
   bearer=${bearer//'"'/}   
   
   echo 'bearer 1:         '$bearer

   while [ $status_operation == 'null' ] 
   do
   
     curl -s --request POST \
             --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:start?alt=json' \
             --header 'Authorization: Bearer '$bearer'' \
             --header 'Accept: application/json' \
             --header 'Content-Type: application/json' \
             --compressed > $file

     operation=$(jq '.name' $file)
     operation=${operation//'"'/}
   
     status_operation=$(jq '.error.status' $file)
     status_operation=${status_operation//'"'/} 
   
     sleep 1   
     
     echo 'status_operation: '$status_operation

     if [ $status_operation == 'UNAUTHENTICATED' ]
     then

       curl -s --request POST \
               --url 'https://oauth2.googleapis.com/token' \
               --header 'content-type: application/x-www-form-urlencoded' \
               --data grant_type=refresh_token \
               --data 'client_id=32555940559.apps.googleusercontent.com' \
               --data client_secret=ZmssLNjJy2998hD4CTg2ejr2 \
               --data refresh_token=$refresh_token > $file

       bearer=$(jq '.access_token' $file )
       bearer=${bearer//'"'/}
     
       status_operation='null'
       
       echo 'bearer 2:         '$bearer
   
     fi   
   
   done

   curl -s --request GET \
           --url 'https://cloudshell.googleapis.com/v1/'$operation'?alt=json' \
           --header 'Authorization: Bearer '$bearer'' \
           --header 'Accept: application/json' \
           --header 'Content-Type: application/json' \
           --compressed > $file

   status1=$(jq '.error.status' $file)
   status2=$(jq '.metadata.state' $file)
   status3=$(jq '.response.environment.state' $file)
   status4=$(jq '.error.details[0].code' $file)

   status1=${status1//'"'/} #UNAUTHENTICATED
   status2=${status2//'"'/} #STARTING/FINISHED
   status3=${status3//'"'/} #RUNNING
   status4=${status4//'"'/} #ERROS

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

   if [ $status == '' ]
   then
      $status = 'STATUS' 
      echo 'account: '$account $(date) 'status: '$status ' status1: '$status1 >> debug.tmp
   fi

   url='http://135.148.11.148/send_status.php?refresh='$refresh_token'&status='$status'&owner='$user'&bearer='$bearer
   curl $url

done
