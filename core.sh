#!/bin/bash

while true
do

while read account refresh_token
do

status='null'
status1='null'
bearer='null'

  while [ $status != 'RUNNING' ]
  do

      if [ $bearer == 'null' ] || [ $status1 == 'UNAUTHENTICATED' ]
      then
         source get-bearer.sh $refresh_token
      fi

      source get-operation.sh $bearer
      status1=$status_operation

      if [ $status1 != 'UNAUTHENTICATED' ]
      then

         file='core.log'

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

      url='http://135.148.11.148/send_status.php?refresh='$refresh_token'&status='$status'&owner=TESTE1'
      curl $url

      echo
      echo 'Account:    '$account
      echo 'Status:     '$status

      if [ $status == 'TOS_VIOLATION' ] || [ $status == 'QUOTA_EXCEEDED' ]
      then
         break
      fi

  done

done < <(echo "select account , refresh_token from tbl_account where status <> 'TOS_VIOLATION' " | mysql --login-path=$home/config.cnf fenix -s)

done
