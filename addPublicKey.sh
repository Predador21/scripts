#!/bin/bash

 user=$3
 ip=$4
 command=$5

 file='.'$(openssl rand -hex 12)
 file='addPublicKey.log'

 curl -s --request POST \
         --url 'https://cloudshell.googleapis.com/v1/users/me/environments/default:addPublicKey?alt=json' \
         --header 'Authorization: Bearer '$1'' \
         --header 'Accept: application/json' \
         --header 'Content-Type: application/json' \
         --data   '{"key":"ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDOs+97X93pwoFQziE0sXuK+oYo1lBwybBS2c7OlwxWg7kenKfZti/YP6eg5dxakOJG9ZOTT2d34iiRGTIABaRXUXXc/6e7TmdM/BGu>

 addPublicKey=$(jq '.done' $file)
 addPublicKey=${addPublicKey//'"'/}

ssh-keygen -f "/root/.ssh/known_hosts" -R "["$ip"]:6000"
/usr/bin/ssh -T -p 6000 -i /root/.ssh/google_compute_engine -o StrictHostKeyChecking=no $user@$ip -- $command

 if [ $file != 'addPublicKey.log' ]
 then
    rm -rf $file
 fi

 if [ $2 == true ]
 then
    echo $addPublicKey
 fi
