#!/bin/bash

 file='.'$(openssl rand -hex 12)
 file='get-operation.log'

 curl -s --request POST \
         --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:start?alt=json' \
         --header 'Authorization: Bearer '$1'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --compressed > $file

 operation=$(jq '.name' $file)
 operation=${operation//'"'/}

 status_operation=$(jq '.error.status' $file)
 status_operation=${status_operation//'"'/}

 if [ $file != 'get-operation.log' ]
 then
    rm -rf $file
 fi

 if [ $2 == true ]
 then
    echo $status_operation
 fi
