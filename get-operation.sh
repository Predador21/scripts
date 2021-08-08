#!/bin/bash

 file='.'$(openssl rand -hex 12)

 curl -s --request POST \
         --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:start?alt=json' \
         --header 'Authorization: Bearer '$1'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --compressed > $file

 operation=$(jq '.name' $file)
 operation=${operation//'"'/}

 rm -rf $file
